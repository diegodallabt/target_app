import 'package:hive/hive.dart';
import '../models/user.dart';
import '../../../core/utils/constants.dart';
import '../../../core/errors/auth_exception.dart';
import '../../../core/utils/crypto_helper.dart';
import '../../../core/utils/id_generator.dart';

class AuthService {
  Future<User> login({
    required String username,
    required String password,
  }) async {
    try {
      await Future.delayed(Duration(seconds: AppConstants.loginDelaySeconds));

      if (username == 'admin' && password == '123456') {
        final passwordHash = CryptoHelper.hashPassword(password);
        final user = User(
          id: '672c4c9f1d8b1e412c802ee9',
          username: username,
          name: 'Usuário Teste',
          passwordHash: passwordHash,
        );

        final userBox = await Hive.openBox<User>(AppConstants.userBoxName);
        await userBox.put(user.id, user);

        final authBox = await Hive.openBox(AppConstants.authBoxName);
        await authBox.put(AppConstants.currentUserKey, user.id);
        await authBox.put(AppConstants.tokenBoxKey, 'mock_token_${user.id}');

        return user;
      }

      final userBox = await Hive.openBox<User>(AppConstants.userBoxName);
      final user = userBox.values.firstWhere(
        (u) => u.username == username,
        orElse: () => throw InvalidCredentialsException(),
      );

      if (!CryptoHelper.verifyPassword(password, user.passwordHash)) {
        throw InvalidCredentialsException();
      }
      final authBox = await Hive.openBox(AppConstants.authBoxName);
      await authBox.put(AppConstants.currentUserKey, user.id);
      await authBox.put(AppConstants.tokenBoxKey, 'mock_token_${user.id}');

      return user;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthStorageException();
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final authBox = await Hive.openBox(AppConstants.authBoxName);
      final userId = authBox.get(AppConstants.currentUserKey) as String?;

      if (userId == null) return null;

      final userBox = await Hive.openBox<User>(AppConstants.userBoxName);
      return userBox.get(userId);
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final authBox = await Hive.openBox(AppConstants.authBoxName);
      await authBox.clear();
    } catch (e) {
      throw AuthStorageException();
    }
  }

  Future<void> saveToken(String token) async {
    try {
      final authBox = await Hive.openBox(AppConstants.authBoxName);
      await authBox.put(AppConstants.tokenBoxKey, token);
    } catch (e) {
      throw AuthStorageException();
    }
  }

  Future<String?> getToken() async {
    try {
      final authBox = await Hive.openBox(AppConstants.authBoxName);
      return authBox.get(AppConstants.tokenBoxKey) as String?;
    } catch (e) {
      throw AuthStorageException();
    }
  }

  Future<void> clearToken() async {
    try {
      final authBox = await Hive.openBox(AppConstants.authBoxName);
      await authBox.delete(AppConstants.tokenBoxKey);
    } catch (e) {
      throw AuthStorageException();
    }
  }

  Future<User> register({
    required String username,
    required String password,
    required String name,
  }) async {
    try {
      await Future.delayed(Duration(seconds: AppConstants.loginDelaySeconds));

      final userBox = await Hive.openBox<User>(AppConstants.userBoxName);
      
      final existingUsers = userBox.values.where((u) => u.username == username);
      if (existingUsers.isNotEmpty) {
        throw UserAlreadyExistsException();
      }

      final userId = IdGenerator.generateId();
      final passwordHash = CryptoHelper.hashPassword(password);
      final user = User(
        id: userId,
        username: username,
        name: name,
        passwordHash: passwordHash,
      );

      await userBox.put(user.id, user);

      final authBox = await Hive.openBox(AppConstants.authBoxName);
      await authBox.put(AppConstants.currentUserKey, user.id);
      await authBox.put(AppConstants.tokenBoxKey, 'mock_token_$userId');

      return user;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthStorageException();
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_app/core/errors/auth_exception.dart';
import 'package:target_app/modules/login/models/user.dart';
import 'package:target_app/modules/login/services/auth_service.dart';
import 'package:target_app/modules/login/viewmodels/login_viewmodel.dart';

@GenerateMocks([AuthService])
import 'login_viewmodel_test.mocks.dart';

void main() {
  late LoginViewModel viewModel;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    viewModel = LoginViewModel(mockAuthService);
  });

  group('observables', () {
    test('initial values should be correct', () {
      expect(viewModel.username, isEmpty);
      expect(viewModel.password, isEmpty);
      expect(viewModel.name, isEmpty);
      expect(viewModel.confirmPassword, isEmpty);
      expect(viewModel.isPasswordVisible, isFalse);
      expect(viewModel.isConfirmPasswordVisible, isFalse);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.currentUser, isNull);
    });

    test('setUsername should update username and clear error', () {
      viewModel.errorMessage = 'Some error';
      viewModel.setUsername('testuser');

      expect(viewModel.username, equals('testuser'));
      expect(viewModel.errorMessage, isNull);
    });

    test('setPassword should update password and clear error', () {
      viewModel.errorMessage = 'Some error';
      viewModel.setPassword('password123');

      expect(viewModel.password, equals('password123'));
      expect(viewModel.errorMessage, isNull);
    });

    test('setName should update name and clear error', () {
      viewModel.setName('Test User');

      expect(viewModel.name, equals('Test User'));
    });

    test('setConfirmPassword should update confirmPassword', () {
      viewModel.setConfirmPassword('password123');

      expect(viewModel.confirmPassword, equals('password123'));
    });

    test('togglePasswordVisibility should toggle both password fields', () {
      expect(viewModel.isPasswordVisible, isFalse);
      expect(viewModel.isConfirmPasswordVisible, isFalse);

      viewModel.togglePasswordVisibility();

      expect(viewModel.isPasswordVisible, isTrue);
      expect(viewModel.isConfirmPasswordVisible, isTrue);

      viewModel.togglePasswordVisibility();

      expect(viewModel.isPasswordVisible, isFalse);
      expect(viewModel.isConfirmPasswordVisible, isFalse);
    });
  });

  group('computed properties', () {
    test('isUsernameValid should validate username length', () {
      viewModel.setUsername('ab');
      expect(viewModel.isUsernameValid, isFalse);

      viewModel.setUsername('abc');
      expect(viewModel.isUsernameValid, isTrue);
    });

    test('isPasswordValid should validate password length', () {
      viewModel.setPassword('12345');
      expect(viewModel.isPasswordValid, isFalse);

      viewModel.setPassword('123456');
      expect(viewModel.isPasswordValid, isTrue);
    });

    test('isPasswordStrong should check password strength', () {
      viewModel.setPassword('weak');
      expect(viewModel.isPasswordStrong, isFalse);

      viewModel.setPassword('Strong@123');
      expect(viewModel.isPasswordStrong, isTrue);
    });

    test('hasUppercase should detect uppercase letters', () {
      viewModel.setPassword('lowercase');
      expect(viewModel.hasUppercase, isFalse);

      viewModel.setPassword('Uppercase');
      expect(viewModel.hasUppercase, isTrue);
    });

    test('hasLowercase should detect lowercase letters', () {
      viewModel.setPassword('UPPERCASE');
      expect(viewModel.hasLowercase, isFalse);

      viewModel.setPassword('Lowercase');
      expect(viewModel.hasLowercase, isTrue);
    });

    test('hasDigits should detect numbers', () {
      viewModel.setPassword('NoNumbers');
      expect(viewModel.hasDigits, isFalse);

      viewModel.setPassword('Has123');
      expect(viewModel.hasDigits, isTrue);
    });

    test('hasSpecialCharacters should detect special chars', () {
      viewModel.setPassword('NoSpecial123');
      expect(viewModel.hasSpecialCharacters, isFalse);

      viewModel.setPassword('Special@123');
      expect(viewModel.hasSpecialCharacters, isTrue);
    });

    test('hasMinLength should validate minimum length', () {
      viewModel.setPassword('12345');
      expect(viewModel.hasMinLength, isFalse);

      viewModel.setPassword('123456');
      expect(viewModel.hasMinLength, isTrue);
    });

    test('passwordStrengthScore should calculate score correctly', () {
      viewModel.setPassword('');
      expect(viewModel.passwordStrengthScore, equals(0));

      viewModel.setPassword('abc123');
      expect(viewModel.passwordStrengthScore, equals(3));

      viewModel.setPassword('Abc@123');
      expect(viewModel.passwordStrengthScore, equals(5));
    });

    test('isConfirmPasswordValid should match passwords', () {
      viewModel.setPassword('password123');
      viewModel.setConfirmPassword('different');
      expect(viewModel.isConfirmPasswordValid, isFalse);

      viewModel.setConfirmPassword('password123');
      expect(viewModel.isConfirmPasswordValid, isTrue);
    });

    test('isFormValid should validate login form', () {
      expect(viewModel.isFormValid, isFalse);

      viewModel.setUsername('user');
      expect(viewModel.isFormValid, isFalse);

      viewModel.setPassword('123456');
      expect(viewModel.isFormValid, isTrue);
    });

    test('isRegisterFormValid should validate register form', () {
      expect(viewModel.isRegisterFormValid, isFalse);

      viewModel.setName('Test');
      viewModel.setUsername('user');
      viewModel.setPassword('123456');
      expect(viewModel.isRegisterFormValid, isFalse);

      viewModel.setConfirmPassword('123456');
      expect(viewModel.isRegisterFormValid, isTrue);
    });
  });

  group('login action', () {
    test('login with invalid form should set error', () async {
      final result = await viewModel.login();

      expect(result, isFalse);
      expect(viewModel.errorMessage, equals('FILL_FIELDS_CORRECTLY'));
    });

    test('login with valid credentials should succeed', () async {
      viewModel.setUsername('admin');
      viewModel.setPassword('123456');

      final mockUser = User(
        id: '123',
        username: 'admin',
        name: 'Admin',
        passwordHash: 'hash',
      );

      when(mockAuthService.login(
        username: 'admin',
        password: '123456',
      )).thenAnswer((_) async => mockUser);

      when(mockAuthService.saveToken(any)).thenAnswer((_) async => {});

      final result = await viewModel.login();

      expect(result, isTrue);
      expect(viewModel.currentUser, equals(mockUser));
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
    });

    test('login with invalid credentials should set error', () async {
      viewModel.setUsername('wronguser');
      viewModel.setPassword('wrongpass');

      when(mockAuthService.login(
        username: 'wronguser',
        password: 'wrongpass',
      )).thenThrow(InvalidCredentialsException());

      final result = await viewModel.login();

      expect(result, isFalse);
      expect(viewModel.errorMessage, equals('INVALID_CREDENTIALS'));
      expect(viewModel.isLoading, isFalse);
    });
  });

  group('register action', () {
    test('register with invalid form should set error', () async {
      final result = await viewModel.register();

      expect(result, isFalse);
      expect(viewModel.errorMessage, equals('FILL_FIELDS_CORRECTLY'));
    });

    test('register with valid data should succeed', () async {
      viewModel.setName('Test User');
      viewModel.setUsername('testuser');
      viewModel.setPassword('Pass@123');
      viewModel.setConfirmPassword('Pass@123');

      final mockUser = User(
        id: '123',
        username: 'testuser',
        name: 'Test User',
        passwordHash: 'hash',
      );

      when(mockAuthService.register(
        username: 'testuser',
        password: 'Pass@123',
        name: 'Test User',
      )).thenAnswer((_) async => mockUser);

      when(mockAuthService.saveToken(any)).thenAnswer((_) async => {});

      final result = await viewModel.register();

      expect(result, isTrue);
      expect(viewModel.currentUser, equals(mockUser));
      expect(viewModel.isLoading, isFalse);
    });

    test('register with existing user should set error', () async {
      viewModel.setName('Test');
      viewModel.setUsername('existing');
      viewModel.setPassword('Pass@123');
      viewModel.setConfirmPassword('Pass@123');

      when(mockAuthService.register(
        username: 'existing',
        password: 'Pass@123',
        name: 'Test',
      )).thenThrow(UserAlreadyExistsException());

      final result = await viewModel.register();

      expect(result, isFalse);
      expect(viewModel.errorMessage, equals('USER_ALREADY_EXISTS'));
    });
  });

  group('logout action', () {
    test('logout should clear user and reset form', () async {
      viewModel.setUsername('user');
      viewModel.setPassword('pass');
      viewModel.currentUser = User(
        id: '123',
        username: 'user',
        name: 'User',
        passwordHash: 'hash',
      );

      when(mockAuthService.logout()).thenAnswer((_) async => {});
      when(mockAuthService.clearToken()).thenAnswer((_) async => {});

      await viewModel.logout();

      expect(viewModel.currentUser, isNull);
      expect(viewModel.username, isEmpty);
      expect(viewModel.password, isEmpty);
    });
  });

  group('reset action', () {
    test('reset should clear all fields', () {
      viewModel.setUsername('user');
      viewModel.setPassword('pass');
      viewModel.setName('name');
      viewModel.setConfirmPassword('pass');
      viewModel.togglePasswordVisibility();
      viewModel.errorMessage = 'error';

      viewModel.reset();

      expect(viewModel.username, isEmpty);
      expect(viewModel.password, isEmpty);
      expect(viewModel.name, isEmpty);
      expect(viewModel.confirmPassword, isEmpty);
      expect(viewModel.isPasswordVisible, isFalse);
      expect(viewModel.isConfirmPasswordVisible, isFalse);
      expect(viewModel.errorMessage, isNull);
    });
  });
}

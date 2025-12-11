import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/core/utils/crypto_helper.dart';

void main() {
  group('cryptoHelper', () {
    test('hashPassword should return a hashed string', () {
      final password = 'testPassword123';
      final hashed = CryptoHelper.hashPassword(password);

      expect(hashed, isNotEmpty);
      expect(hashed, isNot(equals(password)));
      expect(hashed.length, equals(64));
    });

    test('hashPassword should return consistent hash for same password', () {
      final password = 'mySecurePassword';
      final hash1 = CryptoHelper.hashPassword(password);
      final hash2 = CryptoHelper.hashPassword(password);

      expect(hash1, equals(hash2));
    });

    test('hashPassword should return different hashes for different passwords', () {
      final password1 = 'password1';
      final password2 = 'password2';
      
      final hash1 = CryptoHelper.hashPassword(password1);
      final hash2 = CryptoHelper.hashPassword(password2);

      expect(hash1, isNot(equals(hash2)));
    });

    test('verifyPassword should return true for correct password', () {
      final password = 'correctPassword';
      final hash = CryptoHelper.hashPassword(password);

      expect(CryptoHelper.verifyPassword(password, hash), isTrue);
    });

    test('verifyPassword should return false for incorrect password', () {
      final correctPassword = 'correctPassword';
      final wrongPassword = 'wrongPassword';
      final hash = CryptoHelper.hashPassword(correctPassword);

      expect(CryptoHelper.verifyPassword(wrongPassword, hash), isFalse);
    });
  });
}

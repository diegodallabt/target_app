import 'dart:convert';
import 'package:crypto/crypto.dart';

class CryptoHelper {
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  static bool verifyPassword(String password, String hashedPassword) {
    final passwordHash = hashPassword(password);
    return passwordHash == hashedPassword;
  }
}

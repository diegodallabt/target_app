class Validators {
  static bool isValidPassword(String password) {
    if (password.isEmpty) return false;
    return password.length >= 6;
  }

  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    return hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;
  }

  static bool isValidName(String name) {
    return name.trim().isNotEmpty && name.length >= 2;
  }

  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }
}

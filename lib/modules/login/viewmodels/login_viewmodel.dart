import 'package:mobx/mobx.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../../../core/utils/constants.dart';
import '../../../core/errors/auth_exception.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModel with _$LoginViewModel;

abstract class _LoginViewModel with Store {
  final AuthService _authService;

  _LoginViewModel(this._authService);

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  String name = '';

  @observable
  String confirmPassword = '';

  @observable
  bool isPasswordVisible = false;

  @observable
  bool isConfirmPasswordVisible = false;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  User? currentUser;

  @computed
  bool get isUsernameValid {
    if (username.isEmpty) return true;
    return username.length >= AppConstants.minUsernameLength;
  }

  @computed
  bool get isPasswordValid {
    if (password.isEmpty) return true;
    return password.length >= AppConstants.minPasswordLength;
  }

  @computed
  bool get isPasswordStrong {
    if (password.isEmpty) return false;
    
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    return hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters;
  }

  @computed
  bool get hasUppercase => password.contains(RegExp(r'[A-Z]'));

  @computed
  bool get hasLowercase => password.contains(RegExp(r'[a-z]'));

  @computed
  bool get hasDigits => password.contains(RegExp(r'[0-9]'));

  @computed
  bool get hasSpecialCharacters => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  @computed
  bool get hasMinLength => password.length >= AppConstants.minPasswordLength;

  @computed
  int get passwordStrengthScore {
    int score = 0;
    if (hasMinLength) score++;
    if (hasUppercase) score++;
    if (hasLowercase) score++;
    if (hasDigits) score++;
    if (hasSpecialCharacters) score++;
    return score;
  }

  @computed
  bool get isNameValid {
    if (name.isEmpty) return true;
    return name.length >= AppConstants.minNameLength;
  }

  @computed
  bool get isConfirmPasswordValid {
    if (confirmPassword.isEmpty) return true;
    return confirmPassword == password;
  }

  @computed
  bool get isFormValid =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      isUsernameValid &&
      isPasswordValid;

  @computed
  bool get isRegisterFormValid =>
      username.isNotEmpty &&
      password.isNotEmpty &&
      name.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      isUsernameValid &&
      isPasswordValid &&
      isNameValid &&
      isConfirmPasswordValid;

  @computed
  bool get isAuthenticated => currentUser != null;

  @action
  void setUsername(String value) {
    username = value;
    errorMessage = null;
  }

  @action
  void setPassword(String value) {
    password = value;
    errorMessage = null;
  }

  @action
  void setName(String value) {
    name = value;
    errorMessage = null;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
    errorMessage = null;
  }

  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
  }

  @action
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    isPasswordVisible = !isPasswordVisible;
  }

  @action
  Future<bool> login() async {
    if (!isFormValid) {
      errorMessage = 'FILL_FIELDS_CORRECTLY';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    try {
      final user = await _authService.login(
        username: username,
        password: password,
      );

      await _authService.saveToken('mock_token_123');

      currentUser = user;
      isLoading = false;
      return true;
    } on AuthException catch (e) {
      isLoading = false;
      errorMessage = e.code;
      return false;
    } catch (e) {
      isLoading = false;
      errorMessage = 'UNKNOWN_ERROR';
      return false;
    }
  }
  
  @action
  Future<bool> register() async {
    if (!isRegisterFormValid) {
      errorMessage = 'FILL_FIELDS_CORRECTLY';
      return false;
    }

    isLoading = true;
    errorMessage = null;

    try {
      final user = await _authService.register(
        username: username,
        password: password,
        name: name,
      );

      await _authService.saveToken('mock_token_${user.id}');

      currentUser = user;
      isLoading = false;
      return true;
    } on AuthException catch (e) {
      isLoading = false;
      errorMessage = e.code;
      return false;
    } catch (e) {
      isLoading = false;
      errorMessage = 'UNKNOWN_ERROR';
      return false;
    }
  }

  @action
  Future<void> logout() async {
    isLoading = true;

    try {
      await _authService.logout();
      await _authService.clearToken();

      currentUser = null;
      reset();
    } on AuthException catch (e) {
      errorMessage = e.code;
    } catch (e) {
      errorMessage = 'UNKNOWN_ERROR';
    } finally {
      isLoading = false;
    }
  }

  @action
  void reset() {
    username = '';
    password = '';
    name = '';
    confirmPassword = '';
    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
    isLoading = false;
    errorMessage = null;
  }

  
}

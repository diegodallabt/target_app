// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on _LoginViewModel, Store {
  Computed<bool>? _$isUsernameValidComputed;

  @override
  bool get isUsernameValid =>
      (_$isUsernameValidComputed ??= Computed<bool>(() => super.isUsernameValid,
              name: '_LoginViewModel.isUsernameValid'))
          .value;
  Computed<bool>? _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed ??= Computed<bool>(() => super.isPasswordValid,
              name: '_LoginViewModel.isPasswordValid'))
          .value;
  Computed<bool>? _$isPasswordStrongComputed;

  @override
  bool get isPasswordStrong => (_$isPasswordStrongComputed ??= Computed<bool>(
          () => super.isPasswordStrong,
          name: '_LoginViewModel.isPasswordStrong'))
      .value;
  Computed<bool>? _$hasUppercaseComputed;

  @override
  bool get hasUppercase =>
      (_$hasUppercaseComputed ??= Computed<bool>(() => super.hasUppercase,
              name: '_LoginViewModel.hasUppercase'))
          .value;
  Computed<bool>? _$hasLowercaseComputed;

  @override
  bool get hasLowercase =>
      (_$hasLowercaseComputed ??= Computed<bool>(() => super.hasLowercase,
              name: '_LoginViewModel.hasLowercase'))
          .value;
  Computed<bool>? _$hasDigitsComputed;

  @override
  bool get hasDigits =>
      (_$hasDigitsComputed ??= Computed<bool>(() => super.hasDigits,
              name: '_LoginViewModel.hasDigits'))
          .value;
  Computed<bool>? _$hasSpecialCharactersComputed;

  @override
  bool get hasSpecialCharacters => (_$hasSpecialCharactersComputed ??=
          Computed<bool>(() => super.hasSpecialCharacters,
              name: '_LoginViewModel.hasSpecialCharacters'))
      .value;
  Computed<bool>? _$hasMinLengthComputed;

  @override
  bool get hasMinLength =>
      (_$hasMinLengthComputed ??= Computed<bool>(() => super.hasMinLength,
              name: '_LoginViewModel.hasMinLength'))
          .value;
  Computed<int>? _$passwordStrengthScoreComputed;

  @override
  int get passwordStrengthScore => (_$passwordStrengthScoreComputed ??=
          Computed<int>(() => super.passwordStrengthScore,
              name: '_LoginViewModel.passwordStrengthScore'))
      .value;
  Computed<bool>? _$isNameValidComputed;

  @override
  bool get isNameValid =>
      (_$isNameValidComputed ??= Computed<bool>(() => super.isNameValid,
              name: '_LoginViewModel.isNameValid'))
          .value;
  Computed<bool>? _$isConfirmPasswordValidComputed;

  @override
  bool get isConfirmPasswordValid => (_$isConfirmPasswordValidComputed ??=
          Computed<bool>(() => super.isConfirmPasswordValid,
              name: '_LoginViewModel.isConfirmPasswordValid'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_LoginViewModel.isFormValid'))
          .value;
  Computed<bool>? _$isRegisterFormValidComputed;

  @override
  bool get isRegisterFormValid => (_$isRegisterFormValidComputed ??=
          Computed<bool>(() => super.isRegisterFormValid,
              name: '_LoginViewModel.isRegisterFormValid'))
      .value;
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated =>
      (_$isAuthenticatedComputed ??= Computed<bool>(() => super.isAuthenticated,
              name: '_LoginViewModel.isAuthenticated'))
          .value;

  late final _$usernameAtom =
      Atom(name: '_LoginViewModel.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginViewModel.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$nameAtom = Atom(name: '_LoginViewModel.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_LoginViewModel.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$isPasswordVisibleAtom =
      Atom(name: '_LoginViewModel.isPasswordVisible', context: context);

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  late final _$isConfirmPasswordVisibleAtom =
      Atom(name: '_LoginViewModel.isConfirmPasswordVisible', context: context);

  @override
  bool get isConfirmPasswordVisible {
    _$isConfirmPasswordVisibleAtom.reportRead();
    return super.isConfirmPasswordVisible;
  }

  @override
  set isConfirmPasswordVisible(bool value) {
    _$isConfirmPasswordVisibleAtom
        .reportWrite(value, super.isConfirmPasswordVisible, () {
      super.isConfirmPasswordVisible = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_LoginViewModel.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_LoginViewModel.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_LoginViewModel.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginViewModel.login', context: context);

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$registerAsyncAction =
      AsyncAction('_LoginViewModel.register', context: context);

  @override
  Future<bool> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_LoginViewModel.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_LoginViewModelActionController =
      ActionController(name: '_LoginViewModel', context: context);

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.setName');
    try {
      return super.setName(value);
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmPasswordVisibility() {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.toggleConfirmPasswordVisibility');
    try {
      return super.toggleConfirmPasswordVisibility();
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_LoginViewModelActionController.startAction(
        name: '_LoginViewModel.reset');
    try {
      return super.reset();
    } finally {
      _$_LoginViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
password: ${password},
name: ${name},
confirmPassword: ${confirmPassword},
isPasswordVisible: ${isPasswordVisible},
isConfirmPasswordVisible: ${isConfirmPasswordVisible},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentUser: ${currentUser},
isUsernameValid: ${isUsernameValid},
isPasswordValid: ${isPasswordValid},
isPasswordStrong: ${isPasswordStrong},
hasUppercase: ${hasUppercase},
hasLowercase: ${hasLowercase},
hasDigits: ${hasDigits},
hasSpecialCharacters: ${hasSpecialCharacters},
hasMinLength: ${hasMinLength},
passwordStrengthScore: ${passwordStrengthScore},
isNameValid: ${isNameValid},
isConfirmPasswordValid: ${isConfirmPasswordValid},
isFormValid: ${isFormValid},
isRegisterFormValid: ${isRegisterFormValid},
isAuthenticated: ${isAuthenticated}
    ''';
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Target App';

  @override
  String get loginTitle => 'Login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get developmentFeature => 'Feature under development';

  @override
  String get testCredentials => 'To test, use:';

  @override
  String get logout => 'Logout';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get welcomeMessage => 'Welcome to the app';

  @override
  String invalidUsername(int min) {
    return 'Username must be at least $min characters';
  }

  @override
  String invalidPassword(int min) {
    return 'Password must be at least $min characters';
  }

  @override
  String get fillFieldsCorrectly => 'Please fill in the fields correctly';

  @override
  String get logoutError => 'Error logging out';

  @override
  String get invalidCredentials => 'Invalid username or password';

  @override
  String get register => 'Register';

  @override
  String get name => 'Name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Register now';

  @override
  String invalidName(int min) {
    return 'Name must be at least $min characters';
  }

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get registerSuccess => 'Registration successful!';

  @override
  String get userAlreadyExists => 'User already exists';

  @override
  String get storageError => 'Error accessing storage';

  @override
  String get unknownError => 'Unknown error. Please try again';

  @override
  String get weakPassword =>
      'Weak password. Use uppercase, lowercase, numbers and special characters';

  @override
  String get strongPassword => 'Strong password';

  @override
  String get passwordStrength => 'Password strength';

  @override
  String get passwordRequirements => 'Password requirements:';

  @override
  String get requirementUppercase => 'At least one uppercase letter';

  @override
  String get requirementLowercase => 'At least one lowercase letter';

  @override
  String get requirementNumber => 'At least one number';

  @override
  String get requirementSpecialChar =>
      'At least one special character (!@#\$%^&*)';

  @override
  String requirementMinLength(int min) {
    return 'Minimum $min characters';
  }

  @override
  String get noItemsYet => 'No items yet. \nAdd new items to appear here!';

  @override
  String get newItem => 'New item';

  @override
  String get add => 'Add';

  @override
  String get removeItem => 'Remove item';

  @override
  String removeItemConfirmation(String itemName) {
    return 'Do you want to remove \"$itemName\"?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get itemNameEmpty => 'Item name cannot be empty';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get editItem => 'Edit item';

  @override
  String get itemName => 'Item name';

  @override
  String get itemDescription => 'Description';

  @override
  String get selectIcon => 'Select icon';

  @override
  String get save => 'Save';

  @override
  String get details => 'Details';

  @override
  String get statistics => 'Statistics';

  @override
  String get gridColumns => 'Grid columns';

  @override
  String get totalRows => 'Total rows';

  @override
  String get editsPerformed => 'Edits performed';

  @override
  String get totalCharacters => 'Total characters';

  @override
  String get itemDetails => 'Item details';

  @override
  String get characters => 'characters';

  @override
  String get letters => 'Letters';

  @override
  String get numbers => 'Numbers';

  @override
  String get noDataToDisplay => 'No data to display';

  @override
  String get characterDistribution => 'Character distribution';
}

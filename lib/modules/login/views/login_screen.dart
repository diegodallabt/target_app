import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../../../core/stores/theme/theme_store.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/tab_selector.dart';
import '../../../core/widgets/language_selector.dart';
import '../../../core/widgets/animated_form_field.dart';
import '../../../core/stores/translate/locale_store.dart';
import '../../../core/utils/constants.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final LoginViewModel _viewModel;
  late final LocaleStore _localeStore;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  final _formKey = GlobalKey<FormState>();
  bool _isLoginMode = true;

  @override
  void initState() {
    super.initState();
    _viewModel = Modular.get<LoginViewModel>();
    _localeStore = Modular.get<LocaleStore>();

    final themeStore = Modular.get<ThemeStore>();
    themeStore.resetToDefault();
    _localeStore.resetToDefault();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _animationController.forward();
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _viewModel.reset();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          LanguageSelector(localeStore: _localeStore),
        ],
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.asset(
                        AppConstants.logoPath,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 48),

                    TabSelector(
                      leftLabel: l10n.loginTitle,
                      rightLabel: l10n.register,
                      isLeftSelected: _isLoginMode,
                      onLeftTap: _toggleMode,
                      onRightTap: _toggleMode,
                    ),
                    const SizedBox(height: 32),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ));
                        
                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _isLoginMode
                          ? _buildLoginForm(l10n)
                          : _buildRegisterForm(l10n),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(AppLocalizations l10n) {
    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final username = _viewModel.username;
              final isValid = _viewModel.isUsernameValid;
              final isLoading = _viewModel.isLoading;
              return CustomTextField(
                label: l10n.username,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                errorText:
                    username.isNotEmpty && !isValid
                    ? l10n.invalidUsername(AppConstants.minUsernameLength)
                    : null,
                enabled: !isLoading,
                onChanged: _viewModel.setUsername,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final isVisible = _viewModel.isPasswordVisible;
              final password = _viewModel.password;
              final isValid = _viewModel.isPasswordValid;
              final isLoading = _viewModel.isLoading;
              return CustomTextField(
                label: l10n.password,
                prefixIcon: Icons.lock_outlined,
                obscureText: !isVisible,
                textInputAction: TextInputAction.done,
                errorText:
                    password.isNotEmpty && !isValid
                    ? l10n.invalidPassword(AppConstants.minPasswordLength)
                    : null,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _viewModel.togglePasswordVisibility,
                ),
                onChanged: _viewModel.setPassword,
                onFieldSubmitted: (_) => _handleLogin(),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        _buildErrorMessage(l10n),
        const SizedBox(height: 24),

        Observer(
          builder: (_) {
            final isLoading = _viewModel.isLoading;
            final isValid = _viewModel.isFormValid;
            return PrimaryButton(
              text: l10n.login,
              isLoading: isLoading,
              onPressed: isValid ? _handleLogin : null,
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildRegisterForm(AppLocalizations l10n) {
    return Column(
      key: const ValueKey('register'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final name = _viewModel.name;
              final isValid = _viewModel.isNameValid;
              final isLoading = _viewModel.isLoading;
              return CustomTextField(
                label: l10n.name,
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                errorText:
                    name.isNotEmpty && !isValid
                    ? l10n.invalidName(AppConstants.minNameLength)
                    : null,
                enabled: !isLoading,
                onChanged: _viewModel.setName,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final username = _viewModel.username;
              final isValid = _viewModel.isUsernameValid;
              final isLoading = _viewModel.isLoading;
              return CustomTextField(
                label: l10n.username,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                errorText:
                    username.isNotEmpty && !isValid
                    ? l10n.invalidUsername(AppConstants.minUsernameLength)
                    : null,
                enabled: !isLoading,
                onChanged: _viewModel.setUsername,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final isVisible = _viewModel.isPasswordVisible;
              final password = _viewModel.password;
              final isValid = _viewModel.isPasswordValid;
              final isLoading = _viewModel.isLoading;
              return CustomTextField(
                label: l10n.password,
                prefixIcon: Icons.lock_outlined,
                obscureText: !isVisible,
                textInputAction: TextInputAction.next,
                errorText:
                    password.isNotEmpty && !isValid
                    ? l10n.invalidPassword(AppConstants.minPasswordLength)
                    : null,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _viewModel.togglePasswordVisibility,
                ),
                onChanged: _viewModel.setPassword,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final isVisible = _viewModel.isConfirmPasswordVisible;
              final confirmPassword = _viewModel.confirmPassword;
              final isValid = _viewModel.isConfirmPasswordValid;
              final isLoading = _viewModel.isLoading;
              return CustomTextField(
                label: l10n.confirmPassword,
                prefixIcon: Icons.lock_outlined,
                obscureText: !isVisible,
                textInputAction: TextInputAction.done,
                errorText:
                    confirmPassword.isNotEmpty && !isValid
                    ? l10n.passwordsDoNotMatch
                    : null,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _viewModel.toggleConfirmPasswordVisibility,
                ),
                onChanged: _viewModel.setConfirmPassword,
                onFieldSubmitted: (_) => _handleRegister(),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        Observer(
          builder: (_) {
            if (_viewModel.password.isNotEmpty) {
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - value) * -10),
                    child: Opacity(opacity: value, child: child),
                  );
                },
                child: _buildPasswordStrengthIndicator(l10n),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 8),

        _buildErrorMessage(l10n),
        const SizedBox(height: 24),

        Observer(
          builder: (_) {
            final isLoading = _viewModel.isLoading;
            final isValid = _viewModel.isRegisterFormValid;
            return PrimaryButton(
              text: l10n.createAccount,
              isLoading: isLoading,
              onPressed: isValid ? _handleRegister : null,
            );
          },
        ),
      ],
    );
  }

  Widget _buildErrorMessage(AppLocalizations l10n) {
    return Observer(
      builder: (_) {
        if (_viewModel.errorMessage != null) {
          String errorText;
          switch (_viewModel.errorMessage) {
            case 'FILL_FIELDS_CORRECTLY':
              errorText = l10n.fillFieldsCorrectly;
              break;
            case 'INVALID_CREDENTIALS':
              errorText = l10n.invalidCredentials;
              break;
            case 'LOGOUT_ERROR':
              errorText = l10n.logoutError;
              break;
            case 'USER_ALREADY_EXISTS':
              errorText = l10n.userAlreadyExists;
              break;
            case 'STORAGE_ERROR':
              errorText = l10n.storageError;
              break;
            case 'UNKNOWN_ERROR':
              errorText = l10n.unknownError;
              break;
            default:
              errorText = _viewModel.errorMessage!;
          }
          
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * -10),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      errorText,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _handleLogin() async {
    final success = await _viewModel.login();
    if (success && mounted) {
      Modular.to.navigate('/home/');
    }
  }

  Future<void> _handleRegister() async {
    final success = await _viewModel.register();
    if (success && mounted) {
      Modular.to.navigate('/home/');
    }
  }

  Widget _buildPasswordStrengthIndicator(AppLocalizations l10n) {
    final score = _viewModel.passwordStrengthScore;
    final progressValue = score / 5.0;
    
    Color getStrengthColor() {
      if (score <= 2) return Colors.red;
      if (score <= 3) return Colors.orange;
      if (score <= 4) return Colors.amber;
      return Colors.green;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l10n.passwordStrength,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Text(
                '$score/5',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: getStrengthColor(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: progressValue),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(getStrengthColor()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.passwordRequirements,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            l10n.requirementMinLength(AppConstants.minPasswordLength),
            _viewModel.hasMinLength,
          ),
          _buildRequirementItem(
            l10n.requirementUppercase,
            _viewModel.hasUppercase,
          ),
          _buildRequirementItem(
            l10n.requirementLowercase,
            _viewModel.hasLowercase,
          ),
          _buildRequirementItem(
            l10n.requirementNumber,
            _viewModel.hasDigits,
          ),
          _buildRequirementItem(
            l10n.requirementSpecialChar,
            _viewModel.hasSpecialCharacters,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 200),
            builder: (context, value, child) {
              return Icon(
                isMet ? Icons.check_circle : Icons.cancel,
                size: 16,
                color: isMet 
                    ? Colors.green.withValues(alpha: value)
                    : Colors.red.withValues(alpha: 0.4),
              );
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isMet
                    ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9)
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/animated_form_field.dart';
import '../../../core/utils/constants.dart';
import '../viewmodels/login_viewmodel.dart';
import 'password_strength_indicator.dart';

class RegisterForm extends StatelessWidget {
  final LoginViewModel viewModel;
  final VoidCallback onSubmit;

  const RegisterForm({
    super.key,
    required this.viewModel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      key: const ValueKey('register'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final name = viewModel.name;
              final isValid = viewModel.isNameValid;
              final isLoading = viewModel.isLoading;
              return CustomTextField(
                label: l10n.name,
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                errorText: name.isNotEmpty && !isValid
                    ? l10n.invalidName(AppConstants.minNameLength)
                    : null,
                enabled: !isLoading,
                onChanged: viewModel.setName,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final username = viewModel.username;
              final isValid = viewModel.isUsernameValid;
              final isLoading = viewModel.isLoading;
              return CustomTextField(
                label: l10n.username,
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                errorText: username.isNotEmpty && !isValid
                    ? l10n.invalidUsername(AppConstants.minUsernameLength)
                    : null,
                enabled: !isLoading,
                onChanged: viewModel.setUsername,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final isVisible = viewModel.isPasswordVisible;
              final password = viewModel.password;
              final isValid = viewModel.isPasswordValid;
              final isLoading = viewModel.isLoading;
              return CustomTextField(
                label: l10n.password,
                prefixIcon: Icons.lock_outlined,
                obscureText: !isVisible,
                textInputAction: TextInputAction.next,
                errorText: password.isNotEmpty && !isValid
                    ? l10n.invalidPassword(AppConstants.minPasswordLength)
                    : null,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: viewModel.togglePasswordVisibility,
                ),
                onChanged: viewModel.setPassword,
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        AnimatedFormField(
          child: Observer(
            builder: (_) {
              final isVisible = viewModel.isConfirmPasswordVisible;
              final confirmPassword = viewModel.confirmPassword;
              final isValid = viewModel.isConfirmPasswordValid;
              final isLoading = viewModel.isLoading;
              return CustomTextField(
                label: l10n.confirmPassword,
                prefixIcon: Icons.lock_outlined,
                obscureText: !isVisible,
                textInputAction: TextInputAction.done,
                errorText: confirmPassword.isNotEmpty && !isValid
                    ? l10n.passwordsDoNotMatch
                    : null,
                enabled: !isLoading,
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: viewModel.toggleConfirmPasswordVisibility,
                ),
                onChanged: viewModel.setConfirmPassword,
                onFieldSubmitted: (_) => onSubmit(),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        Observer(
          builder: (_) {
            if (viewModel.password.isNotEmpty) {
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
                child: PasswordStrengthIndicator(viewModel: viewModel),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(height: 24),

        Observer(
          builder: (_) {
            final isLoading = viewModel.isLoading;
            final isValid = viewModel.isRegisterFormValid;
            return PrimaryButton(
              text: l10n.createAccount,
              isLoading: isLoading,
              onPressed: isValid ? onSubmit : null,
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/animated_form_field.dart';
import '../../../core/utils/constants.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginForm extends StatelessWidget {
  final LoginViewModel viewModel;
  final VoidCallback onSubmit;

  const LoginForm({super.key, required this.viewModel, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                textInputAction: TextInputAction.done,
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
                onFieldSubmitted: (_) => onSubmit(),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        Observer(
          builder: (_) {
            final isLoading = viewModel.isLoading;
            final isValid = viewModel.isFormValid;
            return PrimaryButton(
              text: l10n.login,
              isLoading: isLoading,
              onPressed: isValid ? onSubmit : null,
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

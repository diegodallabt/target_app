import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../viewmodels/login_viewmodel.dart';

class ErrorMessage extends StatelessWidget {
  final LoginViewModel viewModel;

  const ErrorMessage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Observer(
      builder: (_) {
        if (viewModel.errorMessage != null) {
          String errorText;
          switch (viewModel.errorMessage) {
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
              errorText = viewModel.errorMessage!;
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
                color: Theme.of(
                  context,
                ).colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.error.withValues(alpha: 0.3),
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
}

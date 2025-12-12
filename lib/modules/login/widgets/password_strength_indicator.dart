import 'package:flutter/material.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../../../core/utils/constants.dart';
import '../viewmodels/login_viewmodel.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final LoginViewModel viewModel;

  const PasswordStrengthIndicator({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final score = viewModel.passwordStrengthScore;
    final progressValue = score / 5.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
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
                  color: _getStrengthColor(score),
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
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getStrengthColor(score),
                  ),
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
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          _PasswordRequirementItem(
            text: l10n.requirementMinLength(AppConstants.minPasswordLength),
            isMet: viewModel.hasMinLength,
          ),
          _PasswordRequirementItem(
            text: l10n.requirementUppercase,
            isMet: viewModel.hasUppercase,
          ),
          _PasswordRequirementItem(
            text: l10n.requirementLowercase,
            isMet: viewModel.hasLowercase,
          ),
          _PasswordRequirementItem(
            text: l10n.requirementNumber,
            isMet: viewModel.hasDigits,
          ),
          _PasswordRequirementItem(
            text: l10n.requirementSpecialChar,
            isMet: viewModel.hasSpecialCharacters,
          ),
        ],
      ),
    );
  }

  Color _getStrengthColor(int score) {
    if (score <= 2) return Colors.red;
    if (score <= 3) return Colors.orange;
    if (score <= 4) return Colors.amber;
    return Colors.green;
  }
}

class _PasswordRequirementItem extends StatelessWidget {
  final String text;
  final bool isMet;

  const _PasswordRequirementItem({required this.text, required this.isMet});

  @override
  Widget build(BuildContext context) {
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
                    ? Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.9)
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

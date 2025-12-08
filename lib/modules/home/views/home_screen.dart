import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:target_app/l10n/app_localizations.dart';

import '../../../core/stores/theme/theme_store.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = Modular.get<ThemeStore>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: Icon(
                themeStore.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => themeStore.toggleTheme(),
              tooltip: themeStore.isDarkMode ? l10n.lightMode : l10n.darkMode,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Modular.to.navigate('/');
            },
            tooltip: l10n.logout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.loginSuccess,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.welcomeMessage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

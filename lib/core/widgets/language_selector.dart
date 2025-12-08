import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../stores/translate/locale_store.dart';

class LanguageSelector extends StatelessWidget {
  final LocaleStore localeStore;

  const LanguageSelector({
    super.key,
    required this.localeStore,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => PopupMenuButton<Locale>(
        icon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localeStore.locale.languageCode == 'pt' ? '🇧🇷' : '🇺🇸',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
        onSelected: (Locale locale) {
          localeStore.setLocale(locale);
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem<Locale>(
            value: Locale('pt', 'BR'),
            child: Row(
              children: [
                Text('🇧🇷', style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Text('Brasil'),
              ],
            ),
          ),
          const PopupMenuItem<Locale>(
            value: Locale('en'),
            child: Row(
              children: [
                Text('🇺🇸', style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Text('United States'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

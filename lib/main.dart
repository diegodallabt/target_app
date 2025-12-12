import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:target_app/l10n/app_localizations.dart';
import 'app_module.dart';
import 'core/stores/theme/theme_store.dart';
import 'core/stores/translate/locale_store.dart';
import 'modules/login/models/user.dart';
import 'modules/login/models/user_preferences.dart';
import 'modules/home/models/grid_item_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserPreferencesAdapter());
  Hive.registerAdapter(GridItemModelAdapter());
  
  runApp(
    ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = Modular.get<ThemeStore>();
    final localeStore = Modular.get<LocaleStore>();

    return Observer(
      builder: (context) {
        return MaterialApp.router(
          title: 'Target App',
          debugShowCheckedModeBanner: false,
          locale: localeStore.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en'),
          ],
          themeMode: themeStore.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6366F1),
              brightness: Brightness.light,
            ).copyWith(
              primary: const Color(0xFF6366F1),
              secondary: const Color(0xFF8B5CF6),
              tertiary: const Color(0xFF06B6D4),
              surface: const Color(0xFFFAFAFA),
              error: const Color(0xFFEF4444),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6366F1),
              brightness: Brightness.dark,
            ).copyWith(
              primary: const Color(0xFF6366F1),
              onPrimary: Colors.white,
              secondary: const Color(0xFF8B5CF6),
              tertiary: const Color(0xFF06B6D4),
              surface: const Color(0xFF1F2937),
              onSurface: const Color(0xFFE5E7EB),
              error: const Color(0xFFF87171),
            ),
            iconTheme: const IconThemeData(
              color: Color(0xFFE5E7EB),
            ),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Color(0xFFE5E7EB),
              ),
            ),
          ),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }
}

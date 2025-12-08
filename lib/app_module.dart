import 'package:flutter_modular/flutter_modular.dart';
import 'core/stores/theme/theme_store.dart';
import 'core/stores/translate/locale_store.dart';
import 'modules/login/login_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<ThemeStore>(ThemeStore.new);
    i.addLazySingleton<LocaleStore>(LocaleStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: LoginModule());
    r.module('/home', module: HomeModule());
  }
}

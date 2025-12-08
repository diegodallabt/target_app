import 'package:flutter_modular/flutter_modular.dart';
import 'services/auth_service.dart';
import 'viewmodels/login_viewmodel.dart';
import 'views/login_screen.dart';

class LoginModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<AuthService>(AuthService.new);

    i.addLazySingleton<LoginViewModel>(
      () => LoginViewModel(Modular.get()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginScreen());
  }
}

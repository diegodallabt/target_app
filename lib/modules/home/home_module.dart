import 'package:flutter_modular/flutter_modular.dart';
import 'views/home_screen.dart';
import 'details/views/details_screen.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomeScreen());
    r.child('/details', child: (context) {
      final args = r.args.data as Map<String, dynamic>;
      return DetailsScreen(
        items: args['items'],
        gridColumns: args['gridColumns'],
      );
    });
  }
}

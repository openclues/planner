import 'package:flutter/material.dart';
import 'package:planner/modules/auth_module/presentation/login_screen.dart';

class AppRouter {
  Route ongeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'loginScreen':
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text("Page is not found")),
                ));
    }
  }
}

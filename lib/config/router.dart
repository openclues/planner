import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/modules/auth_module/bloc/register_bloc/bloc/register_bloc.dart';
import 'package:planner/modules/auth_module/presentation/register_screen.dart';
import 'package:planner/theme/size_settings.dart';

class AppRouter {
  Route ongeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          SizeSettings.init(context);

          return BlocProvider(
            create: (context) => RegisterBloc(),
            child: const RegisterScreen(),
          );
        });

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text("Page is not found")),
                ));
    }
  }
}

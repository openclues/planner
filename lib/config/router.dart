import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/config/auth_token_handler.dart';
import 'package:planner/modules/auth_module/bloc/login_bloc/bloc/login_bloc_bloc.dart';
import 'package:planner/modules/auth_module/bloc/register_bloc/bloc/register_bloc.dart';
import 'package:planner/modules/auth_module/presentation/complete_profile.dart';
import 'package:planner/modules/auth_module/presentation/login_screen.dart';
import 'package:planner/modules/auth_module/presentation/register_screen.dart';
import 'package:planner/modules/home_module/presentation/home_screen.dart';
import 'package:planner/modules/loading_module/bloc/loading_bloc.dart';
import 'package:planner/modules/loading_module/presentation/loading_screen.dart';
import 'package:planner/modules/user_module/bloc/user_bloc.dart';
import 'package:planner/theme/size_settings.dart';

class AppRouter {
  LoadingBloc loadingBloc = LoadingBloc();

  Route ongeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          SizeSettings.init(context);

          return BlocProvider.value(
            value: loadingBloc,
            child: const LoadingScreen(),
          );
        });
      case 'register':
        return MaterialPageRoute(builder: (context) {
          SizeSettings.init(context);
          AuthTokenSaveAndGet.getAuthToken();
          return BlocProvider(
            create: (context) => RegisterBloc(),
            child: const RegisterScreen(),
          );
        });
      case 'complete_profile':
        return MaterialPageRoute(builder: (context) {
          SizeSettings.init(context);
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UserBloc(),
              ),
              BlocProvider.value(
                value: loadingBloc,
              ),
            ],
            child: CompleteProfile(),
          );
        });

      case 'login':
        return MaterialPageRoute(builder: (context) {
          SizeSettings.init(context);

          return BlocProvider(
            create: (context) => LoginBlocBloc(),
            child: const LoginScreen(),
          );
        });

      case 'dash':
        return MaterialPageRoute(builder: (context) {
          SizeSettings.init(context);

          return BlocProvider.value(
            value: loadingBloc,
            child: const HomeScreen(),
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

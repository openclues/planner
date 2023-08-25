import 'package:flutter/material.dart';
import 'package:planner/modules/auth_module/presentation/register_screen.dart';
import 'package:planner/theme/theme.dart';

import 'config/router.dart';
import 'theme/size_settings.dart';

void main() {
  final AppRouter appRouter = AppRouter();

  runApp(MyApp(
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRouter.ongeneratedRoute,
      debugShowCheckedModeBanner: false,
      title: 'PLanner',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode
          .system, // Automatically use light/dark based on system settings
    );
  }
}

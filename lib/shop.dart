import 'package:flutter/material.dart';

import 'app/core/routing/app_routes.dart';
import 'app/core/routing/routes.dart';
import 'app/core/theming/theme.dart';


// ignore: must_be_immutable
class ShopApp extends StatelessWidget {
  AppRoutes appRoutes;
  ShopApp({super.key, required this.appRoutes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.onBoarding,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      onGenerateRoute: appRoutes.generateRoute,
    );
  }
}

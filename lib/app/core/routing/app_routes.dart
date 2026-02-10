import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/di/service_locator.dart';
import 'package:news_app/app/core/routing/routes.dart';
import 'package:news_app/app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:news_app/app/features/auth/auth_features/login/ui/login_screen.dart';
import 'package:news_app/app/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:news_app/app/features/on_boarding/ui/on_boarding_screen.dart';

class AppRoutes {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => OnBoardingCubit(),
            child: OnBoardingScreen(),
          ),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => sl<AuthCubit>(),
            child: LoginScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => Text('No Route Found'));
    }
  }
}

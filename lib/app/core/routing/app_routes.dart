import 'package:first_project/app/core/routing/routes.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_cubit.dart';
import 'package:first_project/app/features/navigation_bar/ui/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/auth_features/login/ui/login_screen.dart';
import '../../features/auth/auth_features/signup/ui/signup_screen.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';
import '../../features/on_boarding/cubit/on_boarding_cubit.dart';
import '../../features/on_boarding/ui/on_boarding_screen.dart';
import '../di/service_locator.dart';
import '../widgets/email_verified_successfully.dart';

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
      case Routes.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => sl<AuthCubit>(),
            child: SignUpView(),
          ),
        );
      case Routes.emailVerifiedSuccessfully:
        return MaterialPageRoute(builder: (_) => EmailVerifiedSuccessfully());
      case Routes.navigation:
        return MaterialPageRoute(builder: (_) => 
        BlocProvider(
          create: (BuildContext context) => sl<NavigationCubit>(),
        child: NavigationButton()
        )
        );
      default:
        return MaterialPageRoute(builder: (_) => Text('No Route Found'));
    }
  }
}

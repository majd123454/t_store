import 'package:first_project/app/features/auth/auth_features/login/ui/widgets/divider_widget.dart';
import 'package:first_project/app/features/auth/auth_features/login/ui/widgets/login_form_section.dart';
import 'package:first_project/app/features/auth/auth_features/login/ui/widgets/login_header_section.dart';
import 'package:first_project/app/features/auth/auth_features/login/ui/widgets/sign_in_methods_section.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  LoginHeaderSection(),
                  LoginFormSection(),
                  DividerWidget(text: TTexts.orSignInWith),
                  SizedBox(height: 16),
                  SignInMethodsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app/app/core/helper/constants/text_strings.dart';
import 'package:news_app/app/features/auth/auth_features/login/ui/widgets/divider_widget.dart';
import 'package:news_app/app/features/auth/auth_features/signup/ui/widgets/sign_up_form_section.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TTexts.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 32),
                const SignUpFormSection(),
                const SizedBox(height: 32),
                const DividerWidget(text: TTexts.orSignUpWith),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

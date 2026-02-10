import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/app/core/helper/constants/enum.dart';
import 'package:news_app/app/core/helper/constants/text_strings.dart';
import 'package:news_app/app/core/helper/extensions.dart';
import 'package:news_app/app/core/helper/spacing.dart';
import 'package:news_app/app/core/routing/routes.dart';
import 'package:news_app/app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:news_app/app/features/auth/logic/cubit/auth_state.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          THelperFunctions.showSnackBar(
            context: context,
            message: 'مرحباً بعودتك',
            type: SnackBarType.success,
          );
          context.pushReplacementNamed(Routes.home);
        }

        if (state is AuthError) {
          THelperFunctions.showSnackBar(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }

        if (state is AuthEmailConfirmationRequired) {
          THelperFunctions.showSnackBar(
            context: context,
            message: 'يرجى تأكيد بريدك الإلكتروني: ${state.email}',
            type: SnackBarType.warning,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: TTexts.email),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: state is AuthLoading ? null : _handleLogin,
                child: state is AuthLoading
                    ? const Text(TTexts.loading)
                    : const Text(TTexts.signIn),
              ),
            ],
          ),
        );
      },
    );
  }
}

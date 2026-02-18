import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../core/helper/constants/enum.dart';
import '../../../../../../core/helper/constants/text_strings.dart';
import '../../../../../../core/helper/extensions.dart';
import '../../../../../../core/helper/spacing.dart';
import '../../../../../../core/helper/validators/validation.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../../logic/cubit/auth_cubit.dart';
import '../../../../logic/cubit/auth_state.dart';

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({super.key});

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text.trim(),
        fullName:
            '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
        phone: _phoneController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailConfirmationRequired) {
          THelperFunctions.showSnackBar(
            context: context,
            message: 'تم إرسال رابط التأكيد إلى ${state.email}',
            type: SnackBarType.success,
          );

          context.pushReplacementNamed(Routes.login);
        } else if (state is AuthError) {
          THelperFunctions.showSnackBar(
            context: context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'First name is required'
                        : null,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.firstName,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Last name is required' : null,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.lastName,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: (value) {
                return TValidator.validateEmail(value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              validator: (value) => TValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call),
                labelText: TTexts.phoneNo,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: _addressController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Address is required' : null,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.location),
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
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
                labelText: TTexts.password,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: _confirmPasswordController,
              validator: (value) => TValidator.validateConfirmPassword(
                value,
                _passwordController,
              ),
              obscureText: _obscurePassword,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 16),
            // const TermsAndPrivacyAgreement(),
            // const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            THelperFunctions.hideKeyboard();
                            _handleRegistration();
                          },
                    child: state is AuthLoading
                        ? const Text(TTexts.loading)
                        : const Text(TTexts.createAccount),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

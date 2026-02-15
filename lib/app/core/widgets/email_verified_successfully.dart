import 'package:flutter/material.dart';
import 'package:news_app/app/core/helper/constants/image_constants.dart';
import 'package:news_app/app/core/helper/constants/text_strings.dart';
import 'package:news_app/app/core/helper/extensions.dart';
import 'package:news_app/app/core/models/success_model.dart';
import 'package:news_app/app/core/routing/routes.dart';
import 'package:news_app/app/core/widgets/success_view.dart';

class EmailVerifiedSuccessfully extends StatelessWidget {
  const EmailVerifiedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessView(
      successModel: SuccessModel(
        image: TImages.staticSuccessIllustration,
        title: TTexts.yourAccountCreatedTitle,
        subTitle: TTexts.yourAccountCreatedSubTitle,
        buttonText: TTexts.tContinue,
        onPressed: () {
          context.pushReplacementNamed(Routes.login);
        },
      ),
    );
  }
}

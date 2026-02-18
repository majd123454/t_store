import 'package:flutter/material.dart';

import '../../../../core/helper/spacing.dart';
import '../../model/on_boarding_model.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.onBoardingModel});
  final OnBoardingModel onBoardingModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image(
            width: THelperFunctions.screenWidth(context) * .8,
            height: THelperFunctions.screenHeight(context) * .6,
            image: AssetImage(onBoardingModel.image),
          ),
          Text(
            onBoardingModel.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            onBoardingModel.subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

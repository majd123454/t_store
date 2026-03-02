import 'package:first_project/app/core/helper/constants/image_constants.dart';
import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/core/helper/spacing.dart';
import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/features/home/data/models/rounded_image_view_model.dart';
import 'package:first_project/app/features/home/ui/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class OtherSameProductsList extends StatelessWidget {
  const OtherSameProductsList({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: 0,
      bottom: 30,
      left: TSizes.defaultSpace,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => RoundedImage(
            roundedImageModel: RoundedImageModel(
              image: TImages.productImage5,
              width: 80,
              border: Border.all(color: AppColors.primary),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              padding: const EdgeInsets.all(TSizes.sm),
            ),
          ),
          separatorBuilder: (context, index) =>
              const SizedBox(width: TSizes.spaceBtwItems),
          itemCount: 6,
        ),
      ),
    );
  }
}

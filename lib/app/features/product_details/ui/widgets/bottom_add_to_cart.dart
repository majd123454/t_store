import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/core/helper/spacing.dart';
import 'package:first_project/app/core/models/circular_icon_view_model.dart';
import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/core/widgets/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkGrey : AppColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                circularIconModel: CircularIconModel(
                  icon: Iconsax.minus,
                  height: 40,
                  width: 40,
                  color: AppColors.white,
                  backgroundColor: AppColors.darkerGrey,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text("2", style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              CircularIcon(
                circularIconModel: CircularIconModel(
                  icon: Iconsax.add,
                  height: 40,
                  width: 40,
                  color: AppColors.white,
                  backgroundColor: AppColors.black,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: AppColors.black,
              side: const BorderSide(color: AppColors.black),
            ),
            onPressed: () {},
            child: const Text("Add To Cart"),
          ),
        ],
      ),
    );
  }
}

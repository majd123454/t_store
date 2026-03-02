import 'package:first_project/app/core/helper/spacing.dart';
import 'package:first_project/app/core/models/app_bar_view_model.dart';
import 'package:first_project/app/core/models/circular_icon_view_model.dart';
import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/core/widgets/app_bar.dart';
import 'package:first_project/app/core/widgets/circular_icon.dart';
import 'package:first_project/app/core/widgets/curved_widget.dart';
import 'package:first_project/app/features/product_details/ui/widgets/other_same_products_list.dart';
import 'package:first_project/app/features/product_details/ui/widgets/selected_product_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});

  //ProductImageSlider >> product_image_slider.dart
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return CurvedWidget(
      child: Container(
        decoration: BoxDecoration(
          color: dark ? AppColors.darkGrey : AppColors.light,
        ),
        child: Stack(
          children: [
            const SelectedProductImage(),
            const OtherSameProductsList(),
            CustomAppBar(
              appBarModel: AppBarModel(
                hasArrowBack: true,
                actions: [
                  CircularIcon(
                    circularIconModel: CircularIconModel(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

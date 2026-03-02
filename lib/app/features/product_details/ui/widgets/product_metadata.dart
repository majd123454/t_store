import 'package:first_project/app/core/helper/constants/image_constants.dart';
import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/core/helper/spacing.dart';
import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/core/widgets/brand_title_with_verification.dart';
import 'package:first_project/app/core/widgets/product_price_text.dart';
import 'package:first_project/app/core/widgets/product_title_text.dart';
import 'package:first_project/app/core/widgets/sale_tag.dart';
import 'package:first_project/app/features/home/data/models/rounded_image_view_model.dart';
import 'package:first_project/app/features/home/ui/widgets/rounded_image.dart';
import 'package:flutter/material.dart';

class ProductMetadata extends StatelessWidget {
  const ProductMetadata({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SaleTag(discountPercentage: 44),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              " \$250",
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            ProductPriceText(
              productPriceTextModel: ProductPriceTextModel(
                price: "175",
                smallSize: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        ProductTitleText(
          productTitleTextModel: ProductTitleTextModel(
            title: "Green Nike Sports Jacket",
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(
              productTitleTextModel: ProductTitleTextModel(title: "Status"),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text("In Stock", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            RoundedImage(
              roundedImageModel: RoundedImageModel(
                image: TImages.laptopsIcon,
                width: 32,
                height: 32,
                backgroundColor: dark ? AppColors.black : AppColors.white,
                overlayColor: dark ? AppColors.white : AppColors.black,
              ),
            ),
            const BrandTitleWithVerification(
              brandTitleWithVerificationModel: BrandTitleWithVerificationModel(
                brandName: "Nike",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/core/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../home/data/models/section_heading_view_model.dart';

class ProductDescriptionAndReviewsSection extends StatelessWidget {
  const ProductDescriptionAndReviewsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          sectionHeadingModel: SectionHeadingModel(
            title: "Description",
            showActionButton: false,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        // const ReadMore(
        //   text:
        //       "mahmoud hamdy fathy elashwah flutter developer at myself and i major to make backword by etoo in pes 6 ",
        // ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionHeading(
              sectionHeadingModel: SectionHeadingModel(
                title: "Reviews(199)",
                showActionButton: false,
              ),
            ),
            TextButton(
              onPressed: () {
                // THelperFunctions.navigateToScreen(
                //   context,
                //   const ProductReviewsView(),
                // );
              },
              child: const Icon(Iconsax.arrow_right_3, size: 18),
            ),
          ],
        ),
      ],
    );
  }
}

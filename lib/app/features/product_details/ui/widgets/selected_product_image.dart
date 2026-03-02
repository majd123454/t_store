import 'package:first_project/app/core/helper/constants/image_constants.dart';
import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:flutter/material.dart';

class SelectedProductImage extends StatelessWidget {
  const SelectedProductImage({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 400,
      child: Padding(
        padding: EdgeInsets.all(TSizes.productImageRadius * 3),
        child: Center(child: Image(image: AssetImage(TImages.productImage13))),
      ),
    );
  }
}

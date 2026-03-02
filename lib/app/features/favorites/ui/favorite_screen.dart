import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/core/helper/constants/text_strings.dart';
import 'package:first_project/app/core/helper/spacing.dart';
import 'package:first_project/app/core/models/app_bar_view_model.dart';
import 'package:first_project/app/core/models/circular_icon_view_model.dart';
import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/core/widgets/app_bar.dart';
import 'package:first_project/app/core/widgets/circular_icon.dart';
import 'package:first_project/app/core/widgets/vertical_product_card.dart';
import 'package:first_project/app/features/home/data/models/grid_layout_view_model.dart';
import 'package:first_project/app/features/home/data/models/product_entity.dart';
import 'package:first_project/app/features/home/ui/widgets/grid_layout.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';


class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel: AppBarModel(
          actions: [
            CircularIcon(
              circularIconModel: CircularIconModel(
                color: dark ? AppColors.white : AppColors.dark,
                icon: Iconsax.add,
                onPressed: () =>
                    context.read<NavigationCubit>().updateSelectedIndex(0),
              ),
            ),
          ],
          title: Text(
            TTexts.wishlistView,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                GridLayout(
                  gridLayoutModel: GridLayoutModel(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return VerticalProductCard(
                        product: ProductEntity(
                          id: index.toString(),
                          name: "Product $index",
                          price: 100,
                          images: const ["https://picsum.photos/200"],
                          categoryId: "category-$index",
                          description: "Description $index",
                          rating: 4.5,
                          stock: 5,
                          thumbnail: "https://picsum.photos/200",
                          brandName: "Brand $index",
                          categoryName: "Category $index",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

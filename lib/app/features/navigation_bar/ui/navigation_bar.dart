import 'package:first_project/app/core/helper/spacing.dart';
import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_cubit.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return BlocBuilder<NavigationCubit,NavigationState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: 
          NavigationBar(
            elevation: 0,
            backgroundColor: dark ? AppColors.black : AppColors.white,
            height: 80,
            indicatorColor: dark ? AppColors.black.withOpacity(.5) : AppColors.grey,
            selectedIndex: state is ChangeSelectedIndex ? state.selectedIndex : 0,
            onDestinationSelected: (int index){
              context.read<NavigationCubit>().updateSelectedIndex(index);
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.message_search),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.favorite_chart),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Iconsax.user),
                label: 'Profile',
              ),
            ]
          ),
          body: context.read<NavigationCubit>().getScreen(state is ChangeSelectedIndex ? state.selectedIndex : 0),
        );
      },
    );
  }
}
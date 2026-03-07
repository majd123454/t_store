import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/features/home/data/models/rounded_image_view_model.dart';
import 'package:first_project/app/features/home/ui/widgets/rounded_image.dart';
import 'package:first_project/app/features/settings/data/models/user_profile_tile_model.dart';
import 'package:flutter/material.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key, required this.userProfileTileModel});
  final UserProfileTileModel userProfileTileModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RoundedImage(
        roundedImageModel: RoundedImageModel(
          image: userProfileTileModel.leading,
          width: 50,
          height: 50,
          padding: EdgeInsets.zero,
        ),
      ),
      title: Text(
        userProfileTileModel.title,
        style: Theme.of(
          context,
        ).textTheme.headlineMedium!.apply(color: AppColors.white),
      ),
      subtitle: Text(
        userProfileTileModel.subtitle,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: AppColors.white),
      ),
      trailing: IconButton(
        onPressed: userProfileTileModel.onTap,
        icon: Icon(userProfileTileModel.trailing, color: AppColors.white),
      ),
    );
  }
}

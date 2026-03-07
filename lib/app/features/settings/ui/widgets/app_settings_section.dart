import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/core/helper/extensions.dart';
import 'package:first_project/app/core/helper/logger.dart';
import 'package:first_project/app/core/routing/routes.dart';
import 'package:first_project/app/core/services/notifications/firebase_cloud_messaging.dart';
import 'package:first_project/app/core/widgets/section_heading.dart';
import 'package:first_project/app/features/home/data/models/section_heading_view_model.dart';
import 'package:first_project/app/features/settings/data/models/settings_menu_tile_model.dart';
import 'package:first_project/app/features/settings/ui/widgets/settings_menu_tile_list.dart';
import 'package:flutter/material.dart';

class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({super.key, required this.appSettingsTiles});
  final List<SettingsMenuTileModel> appSettingsTiles;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          sectionHeadingModel: SectionHeadingModel(
            title: "App Settings",
            showActionButton: false,
          ),
        ),
        SettingsMenuTileList(settingsMenuTiles: appSettingsTiles),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () async{
              await NotificationService.instance.deleteToken();
              String? token = await NotificationService.instance.getFcmToken();
              logger(token.toString());
              context.pushReplacementNamed(Routes.login);
            },
            child: const Text("Logout"),
          ),
        ),
      ],
    );
  }
}

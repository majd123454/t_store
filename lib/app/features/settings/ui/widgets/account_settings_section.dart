import 'package:first_project/app/core/widgets/section_heading.dart';
import 'package:first_project/app/features/home/data/models/section_heading_view_model.dart';
import 'package:first_project/app/features/settings/data/models/settings_menu_tile_model.dart';
import 'package:first_project/app/features/settings/ui/widgets/settings_menu_tile_list.dart';
import 'package:flutter/material.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key, required this.accountSettingsTiles});
  final List<SettingsMenuTileModel> accountSettingsTiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          sectionHeadingModel: SectionHeadingModel(
            title: "Account Settings",
            showActionButton: false,
          ),
        ),
        SettingsMenuTileList(settingsMenuTiles: accountSettingsTiles),
      ],
    );
  }
}

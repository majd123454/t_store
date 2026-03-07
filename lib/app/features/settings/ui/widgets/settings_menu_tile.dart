import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:first_project/app/features/settings/data/models/settings_menu_tile_model.dart';
import 'package:flutter/material.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({super.key, required this.settingsMenuTileModel});
  final SettingsMenuTileModel settingsMenuTileModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        settingsMenuTileModel.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onTap: settingsMenuTileModel.onTap,
      subtitle: Text(
        settingsMenuTileModel.subtitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      leading: Icon(
        settingsMenuTileModel.leading,
        color: AppColors.primary,
        size: 28,
      ),
      trailing: settingsMenuTileModel.trailing,
    );
  }
}

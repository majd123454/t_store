//SettingsMenuTileList >> settings_menu_tile.dart
import 'package:first_project/app/core/helper/constants/sizes.dart';
import 'package:first_project/app/features/settings/data/models/settings_menu_tile_model.dart';
import 'package:first_project/app/features/settings/ui/widgets/settings_menu_tile.dart';
import 'package:flutter/material.dart';

class SettingsMenuTileList extends StatelessWidget {
  const SettingsMenuTileList({super.key, required this.settingsMenuTiles});
  final List<SettingsMenuTileModel> settingsMenuTiles;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: TSizes.md),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: settingsMenuTiles
          .map((e) => SettingsMenuTile(settingsMenuTileModel: e))
          .toList(),
    );
  }
}

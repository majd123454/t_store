import 'package:first_project/app/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class CartCounterIconModel {
  final VoidCallback? onPressed;
  final Color? color;
  final int? count;
  CartCounterIconModel({
    this.count = 0,
    this.onPressed,
    this.color = AppColors.white,
  });
}

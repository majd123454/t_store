import 'package:flutter/material.dart';

import '../theming/app_colors.dart';
import 'constants/enum.dart';
import 'logger.dart';

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

Widget horizontalSpace(double width) {
  return SizedBox(width: width);
}

class THelperFunctions {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isDarkMode(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    logger("Is dark mode: $isDark");
    return isDark;
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(milliseconds: 900),
  }) {
    Color getColor() {
      switch (type) {
        case SnackBarType.success:
          return success;
        case SnackBarType.error:
          return error;
        case SnackBarType.warning:
          return warning;
        case SnackBarType.info:
          return info;
      }
    }

    IconData getIcon() {
      switch (type) {
        case SnackBarType.success:
          return Icons.check_circle_outline;
        case SnackBarType.error:
          return Icons.error_outline;
        case SnackBarType.warning:
          return Icons.warning_amber_rounded;
        case SnackBarType.info:
          return Icons.info_outline;
      }
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(getIcon(), color: darkText),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: getColor(),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: duration,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void hideKeyboard() {
    logger("Hiding keyboard");
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      fontFamily: 'Arial',
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
    );
  }
}

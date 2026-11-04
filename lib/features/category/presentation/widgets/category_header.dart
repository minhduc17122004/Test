import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CategoryHeader({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Epilogue',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SvgPicture.asset(AppIcons.arrowRight, width: 7, height: 12),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';

class CategorySidebarItem extends StatelessWidget {
  final String name;
  final String image;
  final bool selected;
  final BorderRadius borderRadius;
  final VoidCallback onTap;

  const CategorySidebarItem({
    super.key,
    required this.name,
    required this.image,
    required this.selected,
    required this.borderRadius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.white : AppColors.lightBlueBackground,
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.airFilter,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 6),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Epilogue',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                height: 1.35,
                color: selected
                    ? AppColors.primaryBright
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

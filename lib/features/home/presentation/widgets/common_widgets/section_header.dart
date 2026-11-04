import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/asset_icon.dart';

class SectionHeader extends StatelessWidget {
  final String iconAsset;
  final String title;
  final Color? titleColor;
  final Color? actionColor;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.iconAsset,
    required this.title,
    this.titleColor,
    this.actionColor,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTitleColor = titleColor ?? AppColors.textPrimary;
    final effectiveActionColor = actionColor ?? AppColors.primary;
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Row(
        children: [
          AssetIcon(asset: iconAsset, size: 22),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: effectiveTitleColor,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onViewAll,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Xem tất cả',
                  style: TextStyle(color: effectiveActionColor, fontSize: 12),
                ),
                const SizedBox(width: 2),
                AssetIcon(
                  asset: AppIcons.doubleAltArrowRight,
                  size: 14,
                  color: effectiveActionColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

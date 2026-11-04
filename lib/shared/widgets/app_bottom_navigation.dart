import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';

import '../../core/theme/app_colors.dart';
import 'asset_icon.dart';

class AppBottomNavItem {
  final String label;
  final String iconAsset;
  final int? badgeCount;

  const AppBottomNavItem({
    required this.label,
    required this.iconAsset,
    this.badgeCount,
  });
}

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const items = <AppBottomNavItem>[
    AppBottomNavItem(label: 'Trang chủ', iconAsset: AppIcons.home),
    AppBottomNavItem(
      label: 'Giỏ hàng',
      iconAsset: AppIcons.cart,
      badgeCount: 12,
    ),
    AppBottomNavItem(label: 'Danh mục', iconAsset: AppIcons.category),
    AppBottomNavItem(label: 'Tin tức', iconAsset: AppIcons.news),
    AppBottomNavItem(label: 'Tài khoản', iconAsset: AppIcons.account),
  ];

  static const _selectedColor = AppColors.primaryBright;
  static const _unselectedColor = AppColors.navigationInactive;
  static const _badgeColor = AppColors.badge;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.only(
          top: 4,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom + 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) const SizedBox(width: 24),
              Expanded(
                child: _NavButton(
                  item: items[i],
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final AppBottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? AppBottomNavigation._selectedColor
        : AppBottomNavigation._unselectedColor;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: selected
                  ? AppBottomNavigation._selectedColor
                  : AppColors.transparent,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppBottomNavigation._selectedColor.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 16,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 6),
          Stack(
            clipBehavior: Clip.none,
            children: [
              AssetIcon(asset: item.iconAsset, size: 24, color: color),
              if (item.badgeCount != null)
                Positioned(
                  right: -10,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1,
                    ),
                    decoration: const BoxDecoration(
                      color: AppBottomNavigation._badgeColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      '${item.badgeCount}',
                      style: const TextStyle(
                        fontFamily: 'Epilogue',
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        height: 1.5,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Epilogue',
              fontWeight: FontWeight.w500,
              fontSize: 10,
              height: 1.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

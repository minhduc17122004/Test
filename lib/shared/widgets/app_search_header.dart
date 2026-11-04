import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:my_app/core/theme/app_colors.dart';
import 'package:my_app/shared/widgets/asset_icon.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController searchController;
  final bool showBackButton;
  final VoidCallback? onBack;

  const HomeHeader({
    super.key,
    required this.searchController,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
      child: Row(
        children: [
          if (showBackButton) ...[
            GestureDetector(
              onTap: onBack,
              child: const AssetIcon(
                asset: AppIcons.altArrowLeft,
                size: 32,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 2),
          ],
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm',
                  hintStyle: const TextStyle(
                    color: AppColors.textHint,
                    fontSize: 13,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(11),
                    child: AssetIcon(
                      asset: AppIcons.search,
                      size: 18,
                      color: AppColors.searchIcon,
                    ),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(10),
                    child: AssetIcon(
                      asset: AppIcons.camera,
                      size: 20,
                      color: AppColors.searchIcon,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: 24,
              height: 24,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const AssetIcon(
                    asset: AppIcons.bell,
                    color: AppColors.white,
                    size: 24,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.sale,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

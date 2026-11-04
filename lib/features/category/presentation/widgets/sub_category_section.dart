import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';

import 'package:my_app/core/theme/app_colors.dart';

import '../../../../shared/widgets/asset_icon.dart';
import 'category_data.dart';
import 'sub_category_grid.dart';

class SubCategorySection extends StatelessWidget {
  final SubCategoryGroup group;

  const SubCategorySection({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                group.title,
                style: const TextStyle(
                  fontFamily: 'Epilogue',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1.5,
                      color: AppColors.primaryBright,
                    ),
                  ),
                  SizedBox(width: 2),
                  AssetIcon(
                    asset: AppIcons.doubleAltArrowRight,
                    size: 12,
                    color: AppColors.primaryBright,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SubCategoryGrid(items: group.items),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/asset_icon.dart';

class BrandSection extends StatelessWidget {
  const BrandSection({super.key});

  static const _brands = [
    AppImages.honda,
    AppImages.ford,
    AppImages.bmw,
    AppImages.audi,
    AppImages.kia,
    AppImages.nissan,
    AppImages.chevrolet,
    AppImages.volkswagen,
    AppImages.lexus,
    AppImages.volvo,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              AssetIcon(asset: AppIcons.branch, size: 24),
              SizedBox(width: 4),
              Text(
                'Thương Hiệu Nổi Bật',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 8.0;
              const columns = 5;
              final itemWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: _brands
                    .map(
                      (logo) => SizedBox(
                        width: itemWidth,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(logo, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

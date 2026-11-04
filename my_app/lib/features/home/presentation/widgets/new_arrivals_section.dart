import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';

import 'package:my_app/core/theme/app_colors.dart';

import 'best_seller_section.dart';
import 'common_widgets/common_product_card.dart';
import 'common_widgets/section_header.dart';

class NewArrivalsSection extends StatelessWidget {
  final List<BestSellerProduct> products;

  const NewArrivalsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      color: AppColors.primaryLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            iconAsset: AppIcons.newArrival,
            title: 'Hàng Mới Về',
            titleColor: AppColors.white,
            actionColor: AppColors.white,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < products.length; index++) ...[
                  if (index > 0) const SizedBox(width: 8),
                  CommonProductCard(
                    image: products[index].image,
                    name: products[index].name,
                    price: products[index].price,
                    oldPrice: products[index].oldPrice,
                    discount: products[index].discount,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

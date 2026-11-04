import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';

class PromotionCards extends StatelessWidget {
  const PromotionCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _PromoImage(asset: AppImages.promoBuyOneGiveOne),
                const SizedBox(height: 12),
                _PromoImage(asset: AppImages.promoClearanceShockingPrices),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: _PromoImage(asset: AppImages.promo299kSamePrice)),
        ],
      ),
    );
  }
}

class _PromoImage extends StatelessWidget {
  final String asset;

  const _PromoImage({required this.asset});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(asset, width: double.infinity, fit: BoxFit.fitWidth),
    );
  }
}

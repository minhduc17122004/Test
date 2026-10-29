import 'package:flutter/material.dart';

class PromotionCards extends StatelessWidget {
  const PromotionCards({super.key});

  static const _promos = [
    'assets/images/promo_buy_one_give_one.png',
    'assets/images/promo_299k_same_price.png',
    'assets/images/promo_for_you.png',
    'assets/images/promo_clearance_shocking_prices.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 3),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              'assets/images/Banner_promotion.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemCount: _promos.length,
            itemBuilder: (_, index) => ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.asset(_promos[index], fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

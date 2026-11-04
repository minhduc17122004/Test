import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/asset_icon.dart';

class BestSellerProduct {
  final String name;
  final String price;
  final String oldPrice;
  final String discount;
  final String badge;
  final String image;

  const BestSellerProduct({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.badge,
    required this.image,
  });

  factory BestSellerProduct.fromJson(Map<String, dynamic> json) {
    return BestSellerProduct(
      name: json['name'] as String,
      price: json['price'] as String,
      oldPrice: json['oldPrice'] as String,
      discount: json['discount'] as String,
      badge: json['badge'] as String,
      image: json['image'] as String,
    );
  }
}

Future<List<BestSellerProduct>> loadBestSellers() async {
  final raw = await rootBundle.loadString(AppMocks.bestSellers);
  final list = jsonDecode(raw) as List;
  return list
      .map((e) => BestSellerProduct.fromJson(e as Map<String, dynamic>))
      .toList();
}

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BestSellerProduct>>(
      future: loadBestSellers(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? const <BestSellerProduct>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Row(
                children: [
                  const AssetIcon(asset: AppIcons.like, size: 22),
                  const SizedBox(width: 6),
                  const Text(
                    'Sản Phẩm Bán Chạy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Xem tất cả',
                    style: TextStyle(color: AppColors.primary, fontSize: 12),
                  ),
                  const SizedBox(width: 2),
                  const AssetIcon(
                    asset: AppIcons.doubleAltArrowRight,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int index = 0; index < items.length; index++) ...[
                    if (index > 0) const SizedBox(width: 8),
                    _BestSellerCard(product: items[index]),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BestSellerCard extends StatelessWidget {
  final BestSellerProduct product;

  const _BestSellerCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.overlay,
            offset: Offset(0, 12),
            blurRadius: 24,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColors.overlay,
            offset: Offset(0, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 160 / 136,
            child: Container(
              width: double.infinity,
              color: AppColors.white,
              padding: const EdgeInsets.all(8),
              child: Image.asset(product.image, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AssetIcon(asset: AppIcons.fire, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        product.badge,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.warningText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  product.price,
                  style: const TextStyle(
                    color: AppColors.sale,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      product.oldPrice,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textHint,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product.discount,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.sale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.lightBlueBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Mua ngay',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

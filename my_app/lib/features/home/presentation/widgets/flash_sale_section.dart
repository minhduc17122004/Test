import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/asset_icon.dart';

class FlashSaleProduct {
  final String name;
  final String price;
  final String oldPrice;
  final String discount;
  final int sold;
  final double soldRatio;
  final String image;

  const FlashSaleProduct({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.sold,
    required this.soldRatio,
    required this.image,
  });

  factory FlashSaleProduct.fromJson(Map<String, dynamic> json) {
    return FlashSaleProduct(
      name: json['name'] as String,
      price: json['price'] as String,
      oldPrice: json['oldPrice'] as String,
      discount: json['discount'] as String,
      sold: json['sold'] as int,
      soldRatio: (json['soldRatio'] as num).toDouble(),
      image: json['image'] as String,
    );
  }
}

Future<List<FlashSaleProduct>> loadFlashSale() async {
  final raw = await rootBundle.loadString(AppMocks.flashSale);
  final list = jsonDecode(raw) as List;
  return list
      .map((e) => FlashSaleProduct.fromJson(e as Map<String, dynamic>))
      .toList();
}

class FlashSaleSection extends StatefulWidget {
  const FlashSaleSection({super.key});

  @override
  State<FlashSaleSection> createState() => _FlashSaleSectionState();
}

class _FlashSaleSectionState extends State<FlashSaleSection> {
  late Timer _timer;
  Duration _left = const Duration(hours: 19, minutes: 25);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_left.inSeconds <= 0) return;
      setState(() => _left = _left - const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _two(int v) => v.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final parts = [
      _two(_left.inHours),
      _two(_left.inMinutes % 60),
      _two(_left.inSeconds % 60),
    ];
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.flashSaleStart, AppColors.flashSaleEnd],
        ),
      ),
      child: FutureBuilder<List<FlashSaleProduct>>(
        future: loadFlashSale(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <FlashSaleProduct>[];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Row(
                  children: [
                    const AssetIcon(asset: AppIcons.flashSale, size: 20),
                    const SizedBox(width: 6),
                    const Text(
                      'FLASH SALE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ...parts.asMap().entries.map(
                      (e) => Row(
                        children: [
                          if (e.key > 0)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                ':',
                                style: TextStyle(
                                  color: AppColors.sale,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.sale,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              e.value,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Xem tất cả',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.sale,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const AssetIcon(
                      asset: AppIcons.doubleAltArrowRight,
                      size: 12,
                      color: AppColors.sale,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int index = 0; index < items.length; index++) ...[
                        if (index > 0) const SizedBox(width: 8),
                        _FlashSaleCard(product: items[index]),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}

class _FlashSaleCard extends StatelessWidget {
  final FlashSaleProduct product;

  const _FlashSaleCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
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
                _SoldProgress(ratio: product.soldRatio),
                const SizedBox(height: 4),
                Text(
                  'Đã bán ${product.sold} sản phẩm',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
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

class _SoldProgress extends StatelessWidget {
  final double ratio;

  const _SoldProgress({required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 6,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: AppColors.saleBackground,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                height: 6,
                margin: const EdgeInsets.only(top: 3),
                width: maxW * ratio.clamp(0.0, 1.0),
                decoration: BoxDecoration(
                  color: AppColors.sale,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Positioned(
                left: (maxW * ratio.clamp(0.0, 1.0) - 8).clamp(0.0, maxW - 16),
                top: 0,
                child: const AssetIcon(asset: AppIcons.fire, size: 14),
              ),
            ],
          );
        },
      ),
    );
  }
}

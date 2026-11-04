import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/asset_icon.dart';
import 'best_seller_section.dart';
import 'common_widgets/common_product_card.dart';

Future<List<BestSellerProduct>> loadForYou() async {
  final raw = await rootBundle.loadString(AppMocks.bestSellers);
  final list = jsonDecode(raw) as List;
  return list
      .map((e) => BestSellerProduct.fromJson(e as Map<String, dynamic>))
      .toList();
}

class ForYouSection extends StatelessWidget {
  const ForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: FutureBuilder<List<BestSellerProduct>>(
        future: loadForYou(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <BestSellerProduct>[];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Row(
                  children: [
                    AssetIcon(asset: AppIcons.star, size: 22),
                    SizedBox(width: 6),
                    Text(
                      'Dành Cho Bạn',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Xem tất cả',
                      style: TextStyle(color: AppColors.primary, fontSize: 12),
                    ),
                    SizedBox(width: 2),
                    AssetIcon(
                      asset: AppIcons.doubleAltArrowRight,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _ForYouRow(items: items),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ForYouRow extends StatefulWidget {
  final List<BestSellerProduct> items;

  const _ForYouRow({required this.items});

  @override
  State<_ForYouRow> createState() => _ForYouRowState();
}

class _ForYouRowState extends State<_ForYouRow> {
  final _cardKey = GlobalKey();
  double? _cardHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void didUpdateWidget(covariant _ForYouRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
    }
  }

  void _measure() {
    final box = _cardKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !mounted) return;
    final h = box.size.height;
    if (_cardHeight != h) setState(() => _cardHeight = h);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 160,
            height: _cardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(AppImages.promoForYou, fit: BoxFit.cover),
            ),
          ),
          for (int index = 0; index < widget.items.length; index++) ...[
            const SizedBox(width: 8),
            CommonProductCard(
              key: index == 0 ? _cardKey : null,
              image: widget.items[index].image,
              name: widget.items[index].name,
              price: widget.items[index].price,
              oldPrice: widget.items[index].oldPrice,
              discount: widget.items[index].discount,
            ),
          ],
        ],
      ),
    );
  }
}

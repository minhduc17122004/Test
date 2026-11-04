import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/best_seller_section.dart';
import '../widgets/brand_section.dart';
import '../widgets/featured_categories.dart';
import '../widgets/featured_articles_section.dart';
import '../widgets/flash_sale_section.dart';
import '../widgets/for_you_section.dart';
import '../../../../shared/widgets/app_search_header.dart';
import '../widgets/new_arrivals_section.dart';
import '../widgets/promo_banners.dart';
import '../widgets/promotion_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            HomeHeader(searchController: _searchController),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: const SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BannerCarousel(),
                      CategoryList(),
                      PromoBanners(),
                      FlashSaleSection(),
                      BrandSection(),
                      BestSellerSection(),
                      PromotionCards(),
                      ForYouSection(),
                      _NewArrivalsLoader(),
                      FeaturedArticlesSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewArrivalsLoader extends StatelessWidget {
  const _NewArrivalsLoader();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BestSellerProduct>>(
      future: loadBestSellers(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? const <BestSellerProduct>[];
        if (items.isEmpty) return const SizedBox.shrink();
        return NewArrivalsSection(products: items);
      },
    );
  }
}

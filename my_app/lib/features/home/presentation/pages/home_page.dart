import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';

import '../widgets/banner_carousel.dart';
import '../widgets/brand_list.dart';
import '../widgets/category_list.dart';
import '../widgets/faq_section.dart';
import '../widgets/flash_sale_section.dart';
import '../widgets/home_header.dart';
import '../widgets/product_section.dart';
import '../widgets/promotion_cards.dart';
import '../widgets/section_title.dart';
import '../../../../shared/widgets/asset_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
      body: SafeArea(
        //bottom: false,
        child: Column(
          children: [
            HomeHeader(searchController: _searchController),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    const BannerCarousel(),
                    const CategoryList(),
                    const FlashSaleSection(),
                    const SectionTitle(title: 'Thương hiệu nổi bật'),
                    const BrandList(),
                    const PromotionCards(),
                    const ProductSection(title: 'Dành Cho Bạn'),
                    const ProductSection(title: 'Hàng Mới Về'),
                    const FaqSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() => _selectedTab = index);
        },
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xffffe9dd),
        destinations: const [
          NavigationDestination(
            icon: AssetIcon(asset: 'assets/icons/home.svg', size: 21),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: AssetIcon(asset: 'assets/icons/grid.svg', size: 21),
            label: 'Danh mục',
          ),
          NavigationDestination(
            icon: AssetIcon(asset: 'assets/icons/orders.svg', size: 21),
            label: 'Đơn hàng',
          ),
          NavigationDestination(
            icon: AssetIcon(asset: 'assets/icons/profile.svg', size: 21),
            label: 'Tài khoản',
          ),
        ],
      ),
      )
    );
  }
}

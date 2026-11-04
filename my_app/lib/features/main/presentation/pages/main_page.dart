import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_navigation.dart';
import '../../../account/presentation/pages/account_page.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../../../category/presentation/pages/category_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../news/presentation/pages/news_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  void _go(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: IndexedStack(
          index: _index,
          children: [
            const HomePage(),
            const CartPage(),
            CategoryPage(onBack: () => _go(0)),
            const NewsPage(),
            const AccountPage(),
          ],
        ),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: _index,
          onTap: _go,
        ),
      ),
    );
  }
}

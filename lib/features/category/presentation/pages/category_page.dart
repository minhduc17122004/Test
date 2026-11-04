import 'package:flutter/material.dart';

import 'package:my_app/core/theme/app_colors.dart';

import '../../../../shared/widgets/app_search_header.dart';
import '../widgets/category_content.dart';
import '../widgets/category_data.dart';
import '../widgets/category_sidebar.dart';

class CategoryPage extends StatefulWidget {
  final VoidCallback? onBack;

  const CategoryPage({super.key, this.onBack});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selected = 0;
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
            HomeHeader(
              searchController: _searchController,
              showBackButton: true,
              onBack: widget.onBack,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategorySidebar(
                      selectedIndex: _selected,
                      onSelected: (i) => setState(() => _selected = i),
                    ),
                    CategoryContent(category: parentCategories[_selected]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

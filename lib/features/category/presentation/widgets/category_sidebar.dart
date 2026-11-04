import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'category_data.dart';
import 'category_sidebar_item.dart';

class CategorySidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const CategorySidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      color: AppColors.lightBlueBackground,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: parentCategories.length,
        itemBuilder: (_, index) {
          final item = parentCategories[index];
          final tile = CategorySidebarItem(
            name: item.name,
            image: item.image,
            selected: index == selectedIndex,
            borderRadius: _radiusFor(index),
            onTap: () => onSelected(index),
          );
          // Item kề item được chọn cần nền trắng phía sau để lộ đường cong.
          if ((index - selectedIndex).abs() == 1) {
            return ColoredBox(color: AppColors.white, child: tile);
          }
          return tile;
        },
      ),
    );
  }

  BorderRadius _radiusFor(int index) {
    if (index == selectedIndex) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      );
    }
    if (index == selectedIndex - 1) {
      return const BorderRadius.only(bottomRight: Radius.circular(12));
    }
    if (index == selectedIndex + 1) {
      return const BorderRadius.only(topRight: Radius.circular(12));
    }
    return BorderRadius.zero;
  }
}

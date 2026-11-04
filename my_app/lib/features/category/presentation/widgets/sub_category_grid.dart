import 'package:flutter/material.dart';

import 'category_data.dart';
import 'sub_category_card.dart';

class SubCategoryGrid extends StatelessWidget {
  final List<SubCategoryData> items;

  const SubCategoryGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return SubCategoryCard(name: item.name, image: item.image);
      },
    );
  }
}

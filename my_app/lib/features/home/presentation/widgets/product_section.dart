import 'package:flutter/material.dart';

import 'product_card.dart';
import 'section_title.dart';

class ProductSection extends StatelessWidget {
  final String? title;
  final double itemWidth;

  const ProductSection({super.key, this.title, this.itemWidth = 140});

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      height: 232,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) => ProductCard(index: index, width: itemWidth),
      ),
    );

    if (title == null) {
      return content;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [SectionTitle(title: title!), content],
    );
  }
}

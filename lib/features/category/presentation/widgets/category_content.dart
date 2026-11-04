import 'package:flutter/material.dart';

import 'package:my_app/core/theme/app_colors.dart';

import 'category_data.dart';
import 'category_header.dart';
import 'sub_category_section.dart';

class CategoryContent extends StatelessWidget {
  final CategoryData category;

  const CategoryContent({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.background,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryHeader(title: category.name),
              const SizedBox(height: 12),
              const Divider(height: 1, color: AppColors.cardBorder),
              const SizedBox(height: 12),
              for (int i = 0; i < subCategoryGroups.length; i++) ...[
                if (i > 0) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: AppColors.cardBorder),
                  const SizedBox(height: 12),
                ],
                SubCategorySection(group: subCategoryGroups[i]),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

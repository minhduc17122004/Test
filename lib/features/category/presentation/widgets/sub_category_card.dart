import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SubCategoryCard extends StatelessWidget {
  final String name;
  final String image;

  const SubCategoryCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(6),
          child: Center(child: Image.asset(image, width: 60, height: 60)),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Epilogue',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.35,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

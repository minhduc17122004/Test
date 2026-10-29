import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          const Text(
            'Xem tất cả',
            style: TextStyle(color: AppColors.primary, fontSize: 12),
          ),
          const Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
        ],
      ),
    );
  }
}

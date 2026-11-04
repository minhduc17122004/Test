import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      child: const Text('Tin tức'),
    );
  }
}

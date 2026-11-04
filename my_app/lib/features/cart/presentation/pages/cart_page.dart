import 'package:flutter/material.dart';
import 'package:my_app/core/theme/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      child: const Text('Giỏ hàng'),
    );
  }
}

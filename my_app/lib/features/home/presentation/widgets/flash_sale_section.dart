import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class FlashSaleSection extends StatefulWidget {
  const FlashSaleSection({super.key});

  @override
  State<FlashSaleSection> createState() => _FlashSaleSectionState();
}

class _FlashSaleSectionState extends State<FlashSaleSection> {
  late Timer _timer;
  Duration _left = const Duration(hours: 19, minutes: 25, seconds: 5);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_left.inSeconds <= 0) return;
      setState(() => _left = _left - const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _two(int v) => v.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final parts = [
      _two(_left.inHours),
      _two(_left.inMinutes % 60),
      _two(_left.inSeconds % 60),
    ];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/promo_buy_one_give_one.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: const Color(0xffd5dbe2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Container(
              width: 18,
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Container(
              width: 18,
              height: 5,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: const Color(0xffd5dbe2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xfffff3ec),
            border: Border(
              top: BorderSide(color: AppColors.accent.withOpacity(0.35)),
              bottom: BorderSide(color: AppColors.accent.withOpacity(0.35)),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.flash_on,
                size: 18,
                color: AppColors.accent,
              ),
              const SizedBox(width: 4),
              const Text(
                'FLASH SALE',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
              const SizedBox(width: 10),
              ...parts.asMap().entries.map(
                (e) => Row(
                  children: [
                    if (e.key > 0)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          ':',
                          style: TextStyle(
                            color: AppColors.sale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sale,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'Xem tất cả  ',
                style: TextStyle(color: AppColors.accent, fontSize: 11),
              ),
              const Icon(
                Icons.chevron_right,
                size: 14,
                color: AppColors.accent,
              ),
              const Icon(
                Icons.chevron_right,
                size: 14,
                color: AppColors.accent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

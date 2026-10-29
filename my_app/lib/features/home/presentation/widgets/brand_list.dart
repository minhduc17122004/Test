import 'package:flutter/material.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  static const _brands = [
    ('Bosch', Color(0xff1d2733)),
    ('Denso', Color(0xffc8102e)),
    ('Mann', Color(0xff0a6ebd)),
    ('Mahle', Color(0xfff26b21)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _brands.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final brand = _brands[index];
          return Container(
            width: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffe8ebef)),
            ),
            alignment: Alignment.center,
            child: Text(
              brand.$1,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: brand.$2,
                letterSpacing: 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}

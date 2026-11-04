import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class AssetIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? color;

  const AssetIcon({super.key, required this.asset, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}

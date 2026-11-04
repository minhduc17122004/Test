import 'package:my_app/core/constants/app_assets.dart';

abstract final class AppConstants {
  static const products = [
    (
      name: 'Lọc dầu động cơ Bosch',
      spec: 'P 550335 • Ô tô',
      price: '299.000đ',
      oldPrice: '450.000đ',
      image: AppImages.oilFilter,
      soldRatio: 0.35,
    ),
    (
      name: 'Lọc nhiên liệu Mann',
      spec: 'WK 842/2 • Ô tô',
      price: '349.000đ',
      oldPrice: '520.000đ',
      image: AppImages.fuelFilter,
      soldRatio: 0.55,
    ),
    (
      name: 'Lọc gió điều hòa Denso',
      spec: 'DCC1014 • Cabin',
      price: '259.000đ',
      oldPrice: '390.000đ',
      image: AppImages.cabinAirFilter,
      soldRatio: 0.7,
    ),
    (
      name: 'Lọc gió động cơ Mahle',
      spec: 'LX 1849 • Intake',
      price: '329.000đ',
      oldPrice: '480.000đ',
      image: AppImages.airIntakeFilter,
      soldRatio: 0.45,
    ),
    (
      name: 'Lọc gió Chevrolet',
      spec: 'Air Filter • OEM',
      price: '279.000đ',
      oldPrice: '410.000đ',
      image: AppImages.airFilterChev,
      soldRatio: 0.6,
    ),
  ];
}

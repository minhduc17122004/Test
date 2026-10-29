abstract final class AppConstants {
  static const products = [
    (
      name: 'Lọc dầu động cơ Bosch',
      spec: 'P 550335 • Ô tô',
      price: '299.000đ',
      oldPrice: '450.000đ',
      image: 'assets/images/oil_filter.png',
      soldRatio: 0.35,
    ),
    (
      name: 'Lọc nhiên liệu Mann',
      spec: 'WK 842/2 • Ô tô',
      price: '349.000đ',
      oldPrice: '520.000đ',
      image: 'assets/images/fuel_filter.png',
      soldRatio: 0.55,
    ),
    (
      name: 'Lọc gió điều hòa Denso',
      spec: 'DCC1014 • Cabin',
      price: '259.000đ',
      oldPrice: '390.000đ',
      image: 'assets/images/cabin_air_filter.png',
      soldRatio: 0.7,
    ),
    (
      name: 'Lọc gió động cơ Mahle',
      spec: 'LX 1849 • Intake',
      price: '329.000đ',
      oldPrice: '480.000đ',
      image: 'assets/images/air_intake_filter.png',
      soldRatio: 0.45,
    ),
    (
      name: 'Lọc gió Chevrolet',
      spec: 'Air Filter • OEM',
      price: '279.000đ',
      oldPrice: '410.000đ',
      image: 'assets/images/air_filter_chev.png',
      soldRatio: 0.6,
    ),
  ];
  static const brands = [
    'Bosch',
    'Denso',
    'Mann',
    'Mahle',
    'Mobil',
  ];
  static const categories = [
    ('Bộ Lọc Không Khí', 'assets/images/air_filter.png'),
    ('Bộ Lọc Dầu', 'assets/images/oil_filter.png'),
    ('Bộ Lọc Nhiên Liệu', 'assets/images/fuel_filter.png'),
    ('Bộ Lọc Trong Cabin', 'assets/images/cabin_air_filter.png'),
    ('Bộ Lọc Không Khí', 'assets/images/air_intake_filter.png'),
  ];
  static const faqQuestions = [
    'Sản phẩm được đổi trả trong bao lâu?',
    'Phí vận chuyển là bao nhiêu?',
    'Tôi có thể thanh toán bằng cách nào?',
  ];
}

import 'package:my_app/core/constants/app_assets.dart';

class CategoryData {
  final String name;
  final String image;

  const CategoryData({required this.name, required this.image});
}

class SubCategoryData {
  final String name;
  final String image;

  const SubCategoryData({required this.name, required this.image});
}

class SubCategoryGroup {
  final String title;
  final List<SubCategoryData> items;

  const SubCategoryGroup({required this.title, required this.items});
}

const parentCategories = <CategoryData>[
  CategoryData(name: 'Bộ Lọc Dầu', image: AppImages.oilFilter),
  CategoryData(name: 'Bộ Lọc Không Khí', image: AppImages.airFilter),
  CategoryData(name: 'Bộ Lọc Nhiên Liệu', image: AppImages.fuelFilter),
  CategoryData(name: 'Bộ Lọc Dầu', image: AppImages.oilFilter),
  CategoryData(name: 'Bộ Lọc Dầu', image: AppImages.airFilterChev),
  CategoryData(name: 'Bộ Lọc Dầu', image: AppImages.fuelFilter),
];

const _sub1 = <SubCategoryData>[
  SubCategoryData(name: 'Bộ lọc gió', image: AppImages.airFilter),
  SubCategoryData(name: 'Bộ lọc trong cabin', image: AppImages.cabinAirFilter),
  SubCategoryData(name: 'Bộ lọc nhiên liệu', image: AppImages.fuelFilter),
  SubCategoryData(name: 'Bộ lọc gió', image: AppImages.oilFilter),
  SubCategoryData(name: 'Bộ lọc gió', image: AppImages.airIntakeFilter),
  SubCategoryData(name: 'Bộ lọc gió', image: AppImages.airFilterChev),
];

const subCategoryGroups = <SubCategoryGroup>[
  SubCategoryGroup(title: 'Sub Category 1', items: _sub1),
  SubCategoryGroup(title: 'Sub Category 2', items: _sub1),
];

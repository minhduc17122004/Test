import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/theme/app_colors.dart';

class CategoryItem {
  final String name;
  final String image;

  const CategoryItem({required this.name, required this.image});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}

Future<List<CategoryItem>> loadCategories() async {
  final raw = await rootBundle.loadString(AppMocks.categories);
  final list = jsonDecode(raw) as List;
  return list
      .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
      .toList();
}

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final _scrollController = ScrollController();
  double _progress = 0.0;

  static const _trackWidth = 60.0;
  static const _thumbWidth = 30.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final value = max <= 0
        ? 0.0
        : (_scrollController.offset / max).clamp(0.0, 1.0);
    if ((value - _progress).abs() > 0.001) {
      setState(() => _progress = value);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateProgress)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: FutureBuilder<List<CategoryItem>>(
        future: loadCategories(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <CategoryItem>[];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Text(
                  'Danh mục tiêu biểu',
                  style: TextStyle(
                    fontFamily: 'Epilogue',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 24 / 16,
                    color: AppColors.primaryDarkBlue,
                  ),
                ),
              ),
              SizedBox(
                height: 98,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 4),
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return Container(
                      width: 86,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              item.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontFamily: 'Epilogue',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                height: 16 / 12,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: _trackWidth,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.subtleBorder,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Align(
                    alignment: Alignment(-1.0 + _progress * 2.0, 0.0),
                    child: Container(
                      width: _thumbWidth,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

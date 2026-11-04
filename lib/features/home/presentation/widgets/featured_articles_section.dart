import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_app/core/constants/app_assets.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'common_widgets/article_card.dart';
import 'common_widgets/section_header.dart';

class FeaturedArticle {
  final String title;
  final String date;
  final String image;

  const FeaturedArticle({
    required this.title,
    required this.date,
    required this.image,
  });

  factory FeaturedArticle.fromJson(Map<String, dynamic> json) {
    return FeaturedArticle(
      title: json['title'] as String,
      date: json['date'] as String,
      image: json['image'] as String,
    );
  }
}

Future<List<FeaturedArticle>> loadFeaturedArticles() async {
  final raw = await rootBundle.loadString(AppMocks.featuredArticles);
  final list = jsonDecode(raw) as List;
  return list
      .map((e) => FeaturedArticle.fromJson(e as Map<String, dynamic>))
      .toList();
}

class FeaturedArticlesSection extends StatelessWidget {
  const FeaturedArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
      child: FutureBuilder<List<FeaturedArticle>>(
        future: loadFeaturedArticles(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? const <FeaturedArticle>[];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                iconAsset: AppIcons.article,
                title: 'Bài Viết Nổi Bật',
              ),
              for (int index = 0; index < items.length; index++) ...[
                if (index > 0) const SizedBox(height: 16),
                ArticleCard(
                  image: items[index].image,
                  title: items[index].title,
                  date: items[index].date,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

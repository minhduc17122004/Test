import 'package:flutter/material.dart';

import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/asset_icon.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Câu hỏi thường gặp',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          ...AppConstants.faqQuestions.map(
            (question) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xffe8ebef)),
              ),
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff4a5664),
                  ),
                ),
                trailing: const AssetIcon(
                  asset: 'assets/icons/chevron_down.svg',
                  size: 17,
                  color: Color(0xff687585),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

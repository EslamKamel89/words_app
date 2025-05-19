import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:words_app/core/router/app_routes_names.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class WordCard extends StatelessWidget {
  final WordModel wordModel;

  const WordCard({super.key, required this.wordModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (wordModel.wordTashkeel == null) return;
        Navigator.of(
          context,
        ).pushNamed(AppRoutesNames.versesView, arguments: {'wordTashkeel': wordModel.wordTashkeel});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Surah Name
            // if (wordModel.surah?.name != null)
            //   Text(
            //     "سورة: ${wordModel.surah?.name}",
            //     textAlign: TextAlign.right,
            //     style: TextStyle(
            //       // fontFamily: 'NotoSansArabic',
            //       fontStyle: FontStyle.italic,
            //       color: Colors.indigo.shade700,
            //     ),
            //   ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),

            // const SizedBox(height: 8),

            // Word Without Tashkeel
            // Text(
            //   "الكلمة بدون تشكيل: ${wordModel.word ?? ''}",
            //   textAlign: TextAlign.right,
            //   style: TextStyle(
            //     // fontFamily: 'NotoSansArabic',
            //     fontWeight: FontWeight.bold,
            //     fontSize: 18,
            //     color: Colors.brown.shade900,
            //   ),
            // ).animate().fadeIn(duration: 500.ms).scaleXY(begin: 0.95).then().fade(),

            // const SizedBox(height: 12),

            // Word With Tashkeel
            Text(
              // "الكلمة بالتشكيل: ${wordModel.wordTashkeel ?? ''}",
              " ${wordModel.wordTashkeel ?? ''}",
              textAlign: TextAlign.right,
              style: TextStyle(
                // fontFamily: 'NotoSansArabic',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                // color: Colors.deepOrange.shade700,
              ),
            ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.95).then().fade(),

            // const SizedBox(height: 16),

            // Verse Text + Number
            // if (wordModel.verse != null)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            // Text(
            //   "الآية ${wordModel.verse?.verseNumber ?? ''}",
            //   textAlign: TextAlign.right,
            //   style: TextStyle(
            //     // fontFamily: 'NotoSansArabic',
            //     color: Colors.grey.shade600,
            //   ),
            // ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2),
            // const SizedBox(height: 6),

            // Text(
            //   wordModel.verse?.text ?? '',
            //   textAlign: TextAlign.right,
            //   textDirection: TextDirection.rtl,
            //   maxLines: 4,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(
            //     // fontFamily: 'NotoSansArabic',
            //     fontSize: 20,
            //     height: 2.0,
            //     color: Colors.brown.shade800,
            //   ),
            // ).animate().fadeIn(duration: 800.ms).scaleXY(begin: 0.98, end: 1.0),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

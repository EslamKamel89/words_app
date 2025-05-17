import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SurahAyaCard extends StatelessWidget {
  final String surahName;
  final String verseText;
  final String? verseNumber;

  const SurahAyaCard({
    super.key,
    required this.surahName,
    required this.verseText,
    this.verseNumber,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFFE8F5E9), Color(0xFFBBDEFB)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Surah Name
          Text(
            surahName,
            textAlign: TextAlign.start,
            style: TextStyle(
              // fontFamily: 'NotoSansArabic',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.indigo.shade900,
            ),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

          if (verseNumber != null)
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                "الآية $verseNumber",
                textAlign: TextAlign.right,
                style: TextStyle(
                  // fontFamily: 'NotoSansArabic',
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
            ),

          // Aya Text
          Text(
            verseText,
            textAlign: TextAlign.right,
            style: TextStyle(
              // fontFamily: 'NotoSansArabic',
              fontSize: 22,
              height: 2.0,
              color: Colors.brown.shade900,
              fontWeight: FontWeight.w500,
            ),
            textDirection: TextDirection.rtl,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ).animate().fadeIn(duration: 700.ms).scaleXY(begin: 0.95).then().fade(),
        ],
      ),
    );
  }
}

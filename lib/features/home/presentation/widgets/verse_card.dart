import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:words_app/core/widgets/rounded_container.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';

class VerseCard extends StatelessWidget {
  final VerseEntity verse;

  const VerseCard({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return Container(
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
          // Surah Name + Verse Number Row
          SizedBox(width: double.infinity),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                verse.surahName ?? '',
                style: TextStyle(
                  // fontFamily: 'NotoSansArabic',
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "الآية ${verse.verseNumber ?? ''}",
                style: TextStyle(
                  // fontFamily: 'NotoSansArabic',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

          const SizedBox(height: 12),

          // Verse Text
          Text(
            verse.verseText ?? '',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              // fontFamily: 'NotoSansArabic',
              fontSize: 20,
              height: 2.0,
              color: Colors.brown.shade900,
              fontWeight: FontWeight.w500,
            ),
          ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.98, end: 1.0),
        ],
      ),
    );
  }
}

class VerseLoadingCard extends StatelessWidget {
  const VerseLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return Column(
      children: List.generate(10, (_) {
        return Container(
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
              // Surah Name + Verse Number Row
              SizedBox(width: double.infinity),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RoundedContainer(width: 50, height: 10),
                  const SizedBox(width: 8),
                  RoundedContainer(width: 10, height: 10),
                ],
              ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),

              const SizedBox(height: 12),

              RoundedContainer(width: double.infinity, height: 100),
            ],
          ),
        );
      }),
    );
  }
}

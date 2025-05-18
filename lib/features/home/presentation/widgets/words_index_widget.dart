import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/unique_object_in_array.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class WordsIndexWidget extends StatefulWidget {
  const WordsIndexWidget({super.key});

  @override
  State<WordsIndexWidget> createState() => _WordsIndexWidgetState();
}

class _WordsIndexWidgetState extends State<WordsIndexWidget> {
  late final WordsIndexCubit wordsController;
  @override
  void initState() {
    wordsController = context.read<WordsIndexCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsIndexCubit, ApiResponseModel<PaginationModel<WordModel>>>(
      builder: (context, state) {
        if (state.data?.data != null && state.data!.data!.isNotEmpty == true) {
          if (wordsController.searchQuery.trim().isEmpty) {
            final words = getUniqueListByProperty(state.data!.data!, (word) => word.wordTashkeel);
            return Column(
              children: List.generate(words.length, (index) => WordCard(wordModel: words[index])),
            );
          } else {
            final List<VerseEntity> verses = getUniqueListByProperty(
              VerseEntity.transformWordsToVerses(state.data!.data!),
              (p) => p.verseId,
            );
            return Column(
              children: List.generate(verses.length, (index) => VerseCard(verse: verses[index])),
            );
          }
        }
        if (state.response == ResponseEnum.loading) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(child: Column(children: [Text("لا توجد بيانات")]));
      },
    );
  }
}

class WordCard extends StatelessWidget {
  final WordModel wordModel;

  const WordCard({super.key, required this.wordModel});

  @override
  Widget build(BuildContext context) {
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
          // Surah Name
          if (wordModel.surah?.name != null)
            Text(
              "سورة: ${wordModel.surah?.name}",
              textAlign: TextAlign.right,
              style: TextStyle(
                // fontFamily: 'NotoSansArabic',
                fontStyle: FontStyle.italic,
                color: Colors.indigo.shade700,
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),

          const SizedBox(height: 8),

          // Word Without Tashkeel
          Text(
            "الكلمة بدون تشكيل: ${wordModel.word ?? ''}",
            textAlign: TextAlign.right,
            style: TextStyle(
              // fontFamily: 'NotoSansArabic',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.brown.shade900,
            ),
          ).animate().fadeIn(duration: 500.ms).scaleXY(begin: 0.95).then().fade(),

          const SizedBox(height: 12),

          // Word With Tashkeel
          Text(
            "الكلمة بالتشكيل: ${wordModel.wordTashkeel ?? ''}",
            textAlign: TextAlign.right,
            style: TextStyle(
              // fontFamily: 'NotoSansArabic',
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.deepOrange.shade700,
            ),
          ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.95).then().fade(),

          const SizedBox(height: 16),

          // Verse Text + Number
          if (wordModel.verse != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "الآية ${wordModel.verse?.verseNumber ?? ''}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    // fontFamily: 'NotoSansArabic',
                    color: Colors.grey.shade600,
                  ),
                ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.2),

                const SizedBox(height: 6),

                Text(
                  wordModel.verse?.text ?? '',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    // fontFamily: 'NotoSansArabic',
                    fontSize: 20,
                    height: 2.0,
                    color: Colors.brown.shade800,
                  ),
                ).animate().fadeIn(duration: 800.ms).scaleXY(begin: 0.98, end: 1.0),
              ],
            ),
        ],
      ),
    );
  }
}

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

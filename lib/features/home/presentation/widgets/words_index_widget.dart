import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/unique_object_in_array.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';
import 'package:words_app/features/home/models/root_model/word.dart';
import 'package:words_app/features/home/presentation/widgets/verse_card.dart';
import 'package:words_app/features/home/presentation/widgets/word_card.dart';

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
          return VerseLoadingCard();
        }
        return Center(child: Column(children: [Text("لا توجد بيانات")]));
      },
    );
  }
}

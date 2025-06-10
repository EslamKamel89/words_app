import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/globals.dart';
import 'package:words_app/core/heleprs/unique_object_in_array.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/cubits/verses_index_cubit.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';
import 'package:words_app/features/home/entities/word_entity.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';
import 'package:words_app/features/home/models/root_model/verse.dart';
import 'package:words_app/features/home/models/root_model/word.dart';
import 'package:words_app/features/home/presentation/widgets/load_more_btn.dart';
import 'package:words_app/features/home/presentation/widgets/loading_card.dart';
import 'package:words_app/features/home/presentation/widgets/verse_card.dart';

class VersesView extends StatefulWidget {
  const VersesView({super.key, required this.rootId});
  final int rootId;
  @override
  State<VersesView> createState() => _VersesViewState();
}

class _VersesViewState extends State<VersesView> {
  late final VersesIndexCubit controller;
  @override
  void initState() {
    controller = context.read<VersesIndexCubit>();
    controller.search(widget.rootId);
    super.initState();
  }

  WordEntity? selectedWord;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (a, b) {
        context.read<RootsIndexCubit>().searchInput.text = '';
        Future.delayed(Duration(milliseconds: 10), () {
          if (navigatorKey.currentContext != null) {
            FocusScope.of(navigatorKey.currentContext!).unfocus();
          }
        });
      },
      child: MainScaffold(
        appBarTitle: "نتائج البحث في الآيات",
        resizeToAvoidBottomInset: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (selectedWord != null)
                Row(
                  children: [
                    Text("لقد اخترت الكلمة التالية"),
                    CustomBadge(word: selectedWord!),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedWord = null;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Icon(MdiIcons.trashCan, color: Colors.white),
                      ),
                    ),
                    Sizer(width: 20),
                  ],
                ),
              if (selectedWord == null)
                BlocBuilder<VersesIndexCubit, ApiResponseModel<List<VerseModel>>>(
                  builder: (context, state) {
                    if (state.response == ResponseEnum.loading) {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 100),
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.data == null || state.data?.isEmpty == true) {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 50),
                        child: Text("لا توجد بيانات"),
                      );
                    }
                    List<VerseModel> verses = getUniqueListByProperty(
                      state.data ?? [],
                      (verse) => verse.id,
                    );
                    verses = getUniqueListByProperty(state.data ?? [], (verse) => verse.text);

                    return Column(
                      children: List.generate(verses.length, (index) {
                        final verse = verses[index];
                        return VerseCard(
                          verse: VerseEntity(
                            surahName: verse.surah?.name,
                            verseNumber: verse.verseNumber,
                            verseText: verse.text,
                          ),
                        );
                      }),
                    );
                  },
                ),
              if (selectedWord != null)
                BlocBuilder<WordsIndexCubit, ApiResponseModel<PaginationModel<WordModel>>>(
                  builder: (context, state) {
                    if (state.data?.data != null && state.data!.data!.isNotEmpty == true) {
                      final List<VerseEntity> verses = getUniqueListByProperty(
                        VerseEntity.transformWordsToVerses(state.data!.data!),
                        (p) => p.verseId,
                      );
                      return Column(
                        children: [
                          ...List.generate(
                            verses.length,
                            (index) => VerseCard(verse: verses[index]),
                          ),
                          LoadMoreBtn(),
                        ],
                      );
                    }
                    if (state.response == ResponseEnum.loading) {
                      return LoadingCard();
                    }
                    return Center(child: Column(children: [Text("لا توجد بيانات")]));
                  },
                ),
              Sizer(),
              Divider(),
              Sizer(),
              BlocBuilder<RootsIndexCubit, ApiResponseModel<List<RootModel>>>(
                builder: (context, state) {
                  if (state.data?.isNotEmpty == true) {
                    final List<WordEntity> words = WordEntity.transformRootsToWordsEntity(
                      state.data ?? [],
                    );
                    return Wrap(
                      children: List.generate(
                        words.length,
                        (index) => InkWell(
                          onTap: () {
                            if (words[index].wordTashkeel == null) return;
                            context.read<WordsIndexCubit>().search(words[index].wordTashkeel!);
                            setState(() {
                              selectedWord = words[index];
                            });
                          },
                          child: CustomBadge(word: words[index]),
                        ),
                      ),
                    );
                  }
                  if (state.response == ResponseEnum.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // return Center(child: Column(children: [Text("لا توجد بيانات")]));
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBadge extends StatefulWidget {
  const CustomBadge({super.key, required this.word});
  final WordEntity word;
  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  late final RootsIndexCubit rootsController;
  @override
  void initState() {
    rootsController = context.read<RootsIndexCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = _getRandomColor(context);
    return widget.word.wordTashkeel != null && widget.word.wordTashkeel!.isNotEmpty
        ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color),
          ),
          child: Text(
            widget.word.wordTashkeel ?? '',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
          ),
        )
        : SizedBox();
  }

  final List<Color> _colors = [
    Colors.black,
    Colors.blueGrey,
    Colors.brown,
    Colors.deepPurple,
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.grey[900]!,
    Colors.blue[900]!,
    Colors.green[900]!,
  ];
  Color _getRandomColor(BuildContext context) {
    final random = Random();
    return _colors[random.nextInt(_colors.length)];
  }
}

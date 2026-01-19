import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/extensions/context-extensions.dart';
import 'package:words_app/core/heleprs/hide_keyboard.dart';
import 'package:words_app/core/heleprs/unique_object_in_array.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/widgets/inputs.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/cubits/verses_index_cubit.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';
import 'package:words_app/features/home/entities/word_entity.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';
import 'package:words_app/features/home/models/root_model/verse.dart';
import 'package:words_app/features/home/presentation/widgets/custom_action_button.dart';
import 'package:words_app/features/home/presentation/widgets/custom_badge.dart';
import 'package:words_app/features/home/presentation/widgets/verse_card.dart';

class VersesView extends StatefulWidget {
  const VersesView({super.key, required this.rootId});
  final int rootId;
  @override
  State<VersesView> createState() => _VersesViewState();
}

class _VersesViewState extends State<VersesView> {
  late final VersesIndexCubit controller;
  late final RootsIndexCubit rootsController;
  late final WordsIndexCubit wordsController;
  WordEntity? selectedWord;
  @override
  void initState() {
    controller = context.read<VersesIndexCubit>();
    rootsController = context.read<RootsIndexCubit>();
    wordsController = context.read<WordsIndexCubit>();
    controller.search(widget.rootId);
    super.initState();
  }

  List<WordEntity>? words;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (a, b) {
        context.read<RootsIndexCubit>().searchInput.text = '';
        // hideKeyboard();
        focusNode.unfocus();
      },
      child: MainScaffold(
        appBarTitle: "نتائج البحث في الآيات",
        resizeToAvoidBottomInset: false,
        floatingActionButton: Builder(
          builder: (context) {
            context.watch<RootsIndexCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedWord != null)
                  CustomActionButton(
                    onTap: () async {
                      setState(() {
                        selectedWord = null;
                      });
                      // hideKeyboard();
                    },
                    color: Colors.red,
                    icon: MdiIcons.close,
                  ),
                Sizer(),
                CustomActionButton(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    await showModalBottomSheet(
                      context: context,
                      builder: (a) {
                        return BlocBuilder<RootsIndexCubit, ApiResponseModel<List<RootModel>>>(
                          builder: (context, state) {
                            if (state.data?.isNotEmpty == true) {
                              // words = getUniqueListByProperty(
                              //   words ?? WordEntity.transformRootsToWordsEntity(state.data ?? []),
                              //   (word) => word.wordTashkeel,
                              // );
                              words =
                                  words ?? WordEntity.transformRootsToWordsEntity(state.data ?? []);
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    children: List.generate(
                                      words!.length,
                                      (index) => InkWell(
                                        onTap: () {
                                          if (words![index].wordTashkeel == null) return;
                                          // wordsController.wordId = words![index].wordId!;
                                          // rootsController.searchInput.text =
                                          //     words![index].wordTashkeel!;
                                          setState(() {
                                            selectedWord = words![index];
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: CustomBadge(
                                          word: words![index],
                                          selected: words![index].wordId == selectedWord?.wordId,
                                        ),
                                      ),
                                    ),
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
                        );
                      },
                    );
                    hideKeyboard();
                  },
                  color: context.primaryColor,
                  icon: MdiIcons.magnify,
                ),
              ],
            );
          },
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // if (selectedWord != null)
              //   Row(
              //     children: [
              //       Text("لقد اخترت الكلمة التالية"),
              //       CustomBadge(word: selectedWord!),
              //       Spacer(),
              //       InkWell(
              //         onTap: () {
              //           setState(() {
              //             selectedWord = null;
              //           });
              //         },
              //         child: Container(
              //           padding: EdgeInsets.all(5),
              //           decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              //           child: Icon(MdiIcons.trashCan, color: Colors.white),
              //         ),
              //       ),
              //       Sizer(width: 20),
              //     ],
              //   ),
              // if (selectedWord == null)
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
                  if (selectedWord != null) {
                    verses = verses.where((v) => v.wordId == selectedWord?.wordId).toList();
                  }
                  return Column(
                    children: List.generate(verses.length, (index) {
                      final verse = verses[index];
                      return VerseCard(
                        key: UniqueKey(),
                        verse: VerseEntity(
                          surahId: verse.surahId,
                          surahName: verse.surah?.name,
                          verseNumber: verse.verseNumber,
                          verseText: verse.text,
                        ),
                      );
                    }),
                  );
                },
              ),

              // if (selectedWord != null)
              //   BlocBuilder<WordsIndexCubit, ApiResponseModel<PaginationModel<WordModel>>>(
              //     builder: (context, state) {
              //       if (state.data?.data != null && state.data!.data!.isNotEmpty == true) {
              //         final List<VerseEntity> verses = getUniqueListByProperty(
              //           VerseEntity.transformWordsToVerses(state.data!.data!),
              //           (p) => p.verseId,
              //         );
              //         return Column(
              //           children: [
              //             ...List.generate(
              //               verses.length,
              //               (index) => VerseCard(verse: verses[index]),
              //             ),
              //             LoadMoreBtn(),
              //           ],
              //         );
              //       }
              //       if (state.response == ResponseEnum.loading) {
              //         return LoadingCard();
              //       }
              //       return Center(child: Column(children: [Text("لا توجد بيانات")]));
              //     },
              //   ),
              Sizer(),
              // Divider(),
              // Sizer(),
            ],
          ),
        ),
      ),
    );
  }
}

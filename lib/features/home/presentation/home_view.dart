import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/extensions/context-extensions.dart';
import 'package:words_app/core/widgets/inputs.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/entities/word_entity.dart';
import 'package:words_app/features/home/presentation/widgets/custom_action_button.dart';
import 'package:words_app/features/home/presentation/widgets/custom_badge.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final RootsIndexCubit rootsController;
  late final WordsIndexCubit wordsController;
  final scrollController = ScrollController();
  @override
  void initState() {
    rootsController = context.read<RootsIndexCubit>();
    wordsController = context.read<WordsIndexCubit>();
    // searchController.text = '';
    rootsController.search('');
    wordsController.search('');

    rootsController.searchInput.addListener(() {
      rootsController.search(rootsController.searchInput.text);
      wordsController.search(rootsController.searchInput.text);
    });
    scrollController.addListener(() {
      //    if (scrollController.position.activity?.isScrolling ?? false) {
      //   FocusScope.of(context).unfocus();
      // }
      focusNode.unfocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    // rootsController.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<RootsIndexCubit>();
    return MainScaffold(
      appBarTitle: 'كلمات في القرآن',
      resizeToAvoidBottomInset: false,
      floatingActionButton: HomeViewActionButtons(),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                CustomTextFormField(
                  labelText: "ابحث في القرآن",
                  controller: rootsController.searchInput,
                ),
                Sizer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Builder(
                    builder: (context) {
                      final state = rootsController.state;
                      if (state.data?.isNotEmpty == true) {
                        final List<WordEntity> words = WordEntity.transformRootsToWordsEntity(
                          state.data ?? [],
                        );
                        return Column(
                          children: List.generate(
                            words.length,
                            (index) => InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.of(context).pop();
                                rootsController.searchInput.text = words[index].wordTashkeel ?? '';
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
                ),
                // WordsIndexWidget(),
                Sizer(),
                // Divider(),
                // Sizer(),
                // RootsIndexWidget(clickable: true),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HomeViewActionButtons extends StatefulWidget {
  const HomeViewActionButtons({super.key});

  @override
  State<HomeViewActionButtons> createState() => _HomeViewActionButtonsState();
}

class _HomeViewActionButtonsState extends State<HomeViewActionButtons> {
  late final RootsIndexCubit rootsController;
  @override
  void initState() {
    rootsController = context.read<RootsIndexCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        context.watch<RootsIndexCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (rootsController.searchInput.text != '')
              CustomActionButton(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  rootsController.searchInput.text = '';
                  // hideKeyboard();
                },
                color: Colors.red,
                icon: MdiIcons.close,
              ),
            Sizer(),
            CustomActionButton(
              onTap: () async {
                // FocusScope.of(context).unfocus();
                focusNode.unfocus();
                await Future.delayed(Duration(milliseconds: 10));
                await showModalBottomSheet(
                  context: context,
                  builder: (a) {
                    FocusScope.of(context).unfocus();
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: SingleChildScrollView(
                        child: Builder(
                          builder: (context) {
                            final state = rootsController.state;
                            if (state.data?.isNotEmpty == true) {
                              final List<WordEntity> words = WordEntity.transformRootsToWordsEntity(
                                state.data ?? [],
                              );
                              return Wrap(
                                children: List.generate(
                                  words.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context).pop();
                                      rootsController.searchInput.text =
                                          words[index].wordTashkeel ?? '';
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
                      ),
                    );
                  },
                );
                focusNode.unfocus();
                // hideKeyboard();
              },
              color: context.primaryColor,
              icon: MdiIcons.magnify,
            ),
          ],
        );
      },
    );
  }
}

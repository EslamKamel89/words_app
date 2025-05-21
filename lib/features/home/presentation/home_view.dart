import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/widgets/inputs.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/presentation/widgets/roots_index_widget.dart';
import 'package:words_app/features/home/presentation/widgets/words_index_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final RootsIndexCubit rootsController;
  late final WordsIndexCubit wordsController;
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

    super.initState();
  }

  @override
  void dispose() {
    // rootsController.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'كلمات في القرآن',
      resizeToAvoidBottomInset: false,
      child: SingleChildScrollView(
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                CustomTextFormField(
                  labelText: "ابحث في القرآن",
                  controller: rootsController.searchInput,
                ),
                Sizer(),
                WordsIndexWidget(),
                Sizer(),
                Divider(),
                Sizer(),
                RootsIndexWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}

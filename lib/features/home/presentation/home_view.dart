import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/widgets/inputs.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/entities/word_entity.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';
import 'package:words_app/features/home/presentation/widgets/word_badge.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchController = TextEditingController();
  late final RootsIndexCubit controller;
  @override
  void initState() {
    controller = context.read<RootsIndexCubit>();
    // searchController.text = '';
    controller.search('');

    searchController.addListener(() {
      controller.search(searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'كلمات في القرآن',
      resizeToAvoidBottomInset: false,
      child: SingleChildScrollView(
        child: BlocBuilder<RootsIndexCubit, ApiResponseModel<List<RootModel>>>(
          builder: (context, state) {
            return Column(
              children: [
                CustomTextFormField(labelText: "ابحث في القرآن", controller: searchController),
                Sizer(),
                Builder(
                  builder: (context) {
                    if (state.data?.isNotEmpty == true) {
                      final List<WordEntity> words = WordEntity.transformRootsToWordsEntity(
                        state.data ?? [],
                      );
                      return Wrap(
                        children: List.generate(
                          words.length,
                          (index) => WordBadge(word: words[index]),
                        ),
                      );
                    }
                    if (state.response == ResponseEnum.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(child: Column(children: [Text("لا توجد بيانات")]));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/entities/word_entity.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';
import 'package:words_app/features/home/presentation/widgets/word_badge.dart';

class RootsIndexWidget extends StatelessWidget {
  const RootsIndexWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootsIndexCubit, ApiResponseModel<List<RootModel>>>(
      builder: (context, state) {
        if (state.data?.isNotEmpty == true) {
          final List<WordEntity> words = WordEntity.transformRootsToWordsEntity(state.data ?? []);
          return Wrap(
            children: List.generate(words.length, (index) => WordBadge(word: words[index])),
          );
        }
        if (state.response == ResponseEnum.loading) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(child: Column(children: [Text("لا توجد بيانات")]));
      },
    );
  }
}

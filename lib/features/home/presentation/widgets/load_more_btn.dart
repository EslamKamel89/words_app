import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/extensions/context-extensions.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/cubits/words_index_cubit.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class LoadMoreBtn extends StatefulWidget {
  const LoadMoreBtn({super.key});

  @override
  State<LoadMoreBtn> createState() => _LoadMoreBtnState();
}

class _LoadMoreBtnState extends State<LoadMoreBtn> {
  late final RootsIndexCubit rootsController;
  late final WordsIndexCubit wordsController;
  @override
  void initState() {
    rootsController = context.read<RootsIndexCubit>();
    wordsController = context.read<WordsIndexCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      WordsIndexCubit,
      ApiResponseModel<PaginationModel<WordModel>>
    >(
      builder: (context, state) {
        return wordsController.hasMorePages
            ? Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  wordsController.search(rootsController.searchInput.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  height: 50,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تحميل المزيد من البيانات',
                          style: TextStyle(color: Colors.white),
                        ),
                        state.response == ResponseEnum.loading
                            ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            )
            : SizedBox();
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/constrollers/home_controller.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class WordsIndexCubit
    extends Cubit<ApiResponseModel<PaginationModel<WordModel>>> {
  final HomeController controller = serviceLocator<HomeController>();
  WordsIndexCubit() : super(ApiResponseModel(response: ResponseEnum.initial));
  String searchQuery = '';
  int nextPage = 1;
  bool hasMorePages = true;
  Future search(String newQuery) async {
    final t = prt('search - WordsIndexCumbit');
    emit(state.copyWith(errorMessage: null, response: ResponseEnum.loading));
    if (newQuery == searchQuery) {
      if (!hasMorePages) {
        emit(state);
        return;
      }
      final ApiResponseModel<PaginationModel<WordModel>> model =
          await controller.fetchWords(searchQuery, nextPage);
      hasMorePages = model.data?.currentPage != model.data?.lastPage;
      nextPage = (model.data?.currentPage ?? 0) + 1;
      pr(model, t);
      emit(
        model.copyWith(
          data: model.data?.copyWith(
            data: [...(state.data?.data ?? []), ...(model.data?.data ?? [])],
          ),
        ),
      );
    } else {
      nextPage = 1;
      hasMorePages = true;
      searchQuery = newQuery;
      final ApiResponseModel<PaginationModel<WordModel>> model =
          await controller.fetchWords(searchQuery, nextPage);
      hasMorePages = model.data?.currentPage != model.data?.lastPage;
      nextPage = (model.data?.currentPage ?? 0) + 1;
      pr(model, t);
      emit(model);
    }
  }
}

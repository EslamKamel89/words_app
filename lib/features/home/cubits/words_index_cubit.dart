import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/constrollers/home_controller.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class WordsIndexCubit extends Cubit<ApiResponseModel<PaginationModel<WordModel>>> {
  final HomeController controller = serviceLocator<HomeController>();
  WordsIndexCubit() : super(ApiResponseModel(response: ResponseEnum.initial));
  String searchQuery = '';
  Future search(String query) async {
    final t = prt('search - WordsIndexCumbit');
    searchQuery = query;
    emit(state.copyWith(errorMessage: null, response: ResponseEnum.loading));
    final ApiResponseModel<PaginationModel<WordModel>> model = await controller.fetchWords(query);
    pr(model, t);
    emit(model);
  }
}

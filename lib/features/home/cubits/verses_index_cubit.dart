import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/constrollers/home_controller.dart';
import 'package:words_app/features/home/models/root_model/verse.dart';

class VersesIndexCubit extends Cubit<ApiResponseModel<List<VerseModel>>> {
  final HomeController controller = serviceLocator<HomeController>();
  VersesIndexCubit() : super(ApiResponseModel(response: ResponseEnum.initial, data: []));
  // String searchQuery = '';
  // final searchInput = TextEditingController();
  Future search(int rootId) async {
    final t = prt('search - VersesIndexCubit');
    // searchQuery = rootId;
    emit(state.copyWith(errorMessage: null, response: ResponseEnum.loading, data: []));
    final ApiResponseModel<List<VerseModel>> model = await controller.fetchVerses(rootId);
    pr(model, t);
    emit(model);
  }
}

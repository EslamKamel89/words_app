import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/constrollers/home_controller.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';

class AllRootsCubit extends Cubit<ApiResponseModel<List<RootModel>>> {
  final HomeController controller = serviceLocator<HomeController>();
  AllRootsCubit()
    : super(ApiResponseModel(response: ResponseEnum.initial, data: []));

  Future fetch() async {
    final t = prt('fetch - AllRootsCubit');
    emit(state.copyWith(errorMessage: null, response: ResponseEnum.loading));
    final ApiResponseModel<List<RootModel>> model =
        await controller.fetchAllRoots();
    pr(model, t);
    emit(model);
  }
}

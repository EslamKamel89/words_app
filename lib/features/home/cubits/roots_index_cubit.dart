import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/constrollers/home_controller.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';

class RootsIndexCubit extends Cubit<ApiResponseModel<List<RootModel>>> {
  final HomeController controller = serviceLocator<HomeController>();
  RootsIndexCubit() : super(ApiResponseModel(response: ResponseEnum.initial, data: []));
  String searchQuery = '';
  final searchInput = TextEditingController();
  // List<RootModel> allRoots = [];
  Future search(String query) async {
    final t = prt('search - RootsIndexCubit');
    // if (query.isEmpty && allRoots.isNotEmpty) {
    //   emit(ApiResponseModel(data: allRoots, response: ResponseEnum.success));
    //   return;
    // }
    if (query.isNotEmpty && searchQuery == query) {
      return;
    }
    searchQuery = query;
    pr(query, '$t - query');
    emit(state.copyWith(errorMessage: null, response: ResponseEnum.loading));
    final ApiResponseModel<List<RootModel>> model = await controller.fetchRoots(query);
    // if (allRoots.isEmpty) {
    //   allRoots = model.data ?? [];
    // }
    pr(model, t);
    emit(model);
  }
}

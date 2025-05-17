import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:words_app/core/api_service/api_consumer.dart';
import 'package:words_app/core/api_service/end_points.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/heleprs/snackbar.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';

class HomeController {
  ApiConsumer api = serviceLocator();
  Future<ApiResponseModel<List<RootModel>>> fetch(String search) async {
    final t = prt('fetch - HomeController');
    try {
      final response = await api.get(EndPoint.roots, queryParameter: {"search": search});
      pr(response, '$t - response');

      final List<RootModel> models =
          (response as List).map((json) => RootModel.fromJson(json)).toList();
      return pr(ApiResponseModel(response: ResponseEnum.success, data: models), t);
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      showSnackbar('Error', errorMessage, true);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }
}

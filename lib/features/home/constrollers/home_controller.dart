import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:words_app/core/api_service/api_consumer.dart';
import 'package:words_app/core/api_service/end_points.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/models/pagination_model/pagination_model.dart';
import 'package:words_app/core/service_locator/service_locator.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';
import 'package:words_app/features/home/models/root_model/verse.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class HomeController {
  ApiConsumer api = serviceLocator();
  Future<ApiResponseModel<List<RootModel>>> fetchRoots(String search) async {
    final t = prt('fetchRoots - HomeController');
    try {
      final response = await api.get(
        EndPoint.roots + (search.trim() == '' ? '' : '?search=$search'),
      );
      pr(response, '$t - response');

      final List<RootModel> models =
          (response as List).map((json) => RootModel.fromJson(json)).toList();
      return pr(ApiResponseModel(response: ResponseEnum.success, data: models), t);
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      // showSnackbar('Error', errorMessage, true);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<List<RootModel>>> fetchAllRoots() async {
    final t = prt('fetchRoots - HomeController');
    try {
      final response = await api.get(EndPoint.allroots);
      pr(response, '$t - response');

      final List<RootModel> models =
          (response as List).map((json) => RootModel.fromJson(json)).toList();
      return pr(ApiResponseModel(response: ResponseEnum.success, data: models), t);
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      // showSnackbar('Error', errorMessage, true);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<PaginationModel<WordModel>>> fetchWords(
    String search,
    int page, {
    int? wordId,
  }) async {
    final t = prt('fetchWords - HomeController');
    var queryParamater = {'page': page};
    // pr(wordId, '123456 - wordId - fetchWords - HomeController');
    // if (wordId != null) {
    //   queryParamater.addAll({'wordId': wordId});
    // }
    try {
      final response = await api.get(
        EndPoint.words + (search.trim() == '' ? '' : '?search=$search'),
        queryParameter: queryParamater,
      );
      pr(response, '$t - response');
      PaginationModel<WordModel> pagination = PaginationModel.fromJson(response);
      final List<WordModel> models =
          (response['data'] as List).map((json) => WordModel.fromJson(json)).toList();
      pagination.data = models;
      return pr(ApiResponseModel(response: ResponseEnum.success, data: pagination), t);
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      // showSnackbar('Error', errorMessage, true);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }

  Future<ApiResponseModel<List<VerseModel>>> fetchVerses(int rootId) async {
    final t = prt('fetchVerses - HomeController');
    try {
      final response = await api.get(EndPoint.verses, queryParameter: {'rootId': rootId});
      pr(response, '$t - response');

      final List<VerseModel> models =
          (response as List).map((json) => VerseModel.fromJson(json)).toList();
      return pr(ApiResponseModel(response: ResponseEnum.success, data: models), t);
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        errorMessage = jsonEncode(e.response?.data ?? 'Unknown error occured');
      }
      // showSnackbar('Error', errorMessage, true);
      return pr(ApiResponseModel(errorMessage: errorMessage, response: ResponseEnum.failed), t);
    }
  }
}

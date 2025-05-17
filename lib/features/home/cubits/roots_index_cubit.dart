import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';

class RootsIndexCubit extends Cubit<ApiResponseModel<List<RootModel>>> {
  RootsIndexCubit() : super(ApiResponseModel(response: ResponseEnum.initial, data: []));
}

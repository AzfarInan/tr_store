import 'package:dio/dio.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/core/services/network_service/utils/failures.dart';

extension FutureResponseExtension on Future<Response> {
  Future<(ErrorModel?, T?)> guard<T>(Function(dynamic) parse) async {
    try {
      final response = await this;

      return (null, parse(response.data) as T);
    } on Failure catch (e) {
      ErrorModel errorModel = ErrorModel.fromJson(e.error);

      return (errorModel, null);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/core/services/network_service/utils/failures.dart';

extension FutureResponseExtension on Future<Response> {
  Future<(ErrorModel?, T?)> guard<T>(Function(dynamic) parse) async {
    try {
      final response = await this;

      return (null, parse(response.data) as T);
    } on Failure {
      ErrorModel errorModel = ErrorModel();

      return (errorModel, null);
    }
  }
}

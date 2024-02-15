import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/network/api.dart';
import 'package:tr_store/src/core/services/network_service/network/rest_client.dart';
import 'package:tr_store/src/core/services/network_service/network/rest_client_provider.dart';

abstract class ProductDetailsDataSource {
  Future<Response> getProductDetails({required int productId});
}

class ProductDetailsDataSourceImpl implements ProductDetailsDataSource {
  const ProductDetailsDataSourceImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> getProductDetails({required int productId}) async {
    final response = await restClient.get(
      APIType.public,
      "${API.productList}/$productId",
    );

    return response;
  }
}

final productDetailsDataSourceProvider = Provider<ProductDetailsDataSource>(
  (ref) => ProductDetailsDataSourceImpl(
    restClient: ref.read(networkProvider),
  ),
);

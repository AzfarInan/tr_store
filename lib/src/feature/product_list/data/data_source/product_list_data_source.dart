import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/network/api.dart';
import 'package:tr_store/src/core/services/network_service/network/rest_client.dart';
import 'package:tr_store/src/core/services/network_service/network/rest_client_provider.dart';

abstract class ProductListDataSource {
  Future<Response> getProductList();
}

class ProductListDataSourceImpl implements ProductListDataSource {
  const ProductListDataSourceImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Response> getProductList() async {
    final response = await restClient.get(
      APIType.public,
      API.productList,
    );

    print("getProductList: $response");
    return response;
  }
}

final productListDataSourceProvider = Provider<ProductListDataSource>(
  (ref) => ProductListDataSourceImpl(
    restClient: ref.read(networkProvider),
  ),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/network/api.dart';
import 'package:tr_store/src/core/services/network_service/network/rest_client.dart';

final networkProvider = Provider<RestClient>(
  (ref) {
    return RestClient(
      baseUrl: API.baseUrl,
    );
  },
);

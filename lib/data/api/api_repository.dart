import 'package:restaurantdicoding/data/api/api_service.dart';
import 'package:restaurantdicoding/data/model/resto_model.dart';

import '../model/restodetail_model.dart';
import '../model/restosearch_model.dart';

class ApiRepository {
  final _provider = ApiService();

  Future<RestoListModel> fetchRestoList() {
    return _provider.list();
  }

  Future<RestoDetailModel> fetchRestoDetail(String id) {
    return _provider.detail(id);
  }
  Future<RestoSearchModel> fetchRestoSearch(String keyword) {
    return _provider.search(keyword);
  }
}

class NetworkError extends Error {
  final String message;

  NetworkError(this.message);
}

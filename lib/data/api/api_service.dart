
import 'dart:async';
import 'dart:convert';

import 'package:restaurantdicoding/data/api/api_repository.dart';
import 'package:restaurantdicoding/data/model/resto_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantdicoding/data/model/restodetail_model.dart';
import 'package:restaurantdicoding/data/model/restosearch_model.dart';

class ApiService{
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestoListModel> list() async {
    try{
      final response = await http.get(Uri.parse("$_baseUrl/list")).timeout(const Duration(seconds: 10),onTimeout: (){
        throw TimeoutException('The connection has timed out, Please try again!');
      });
      if (response.statusCode == 200) {
      return RestoListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }}catch(e){
      rethrow;
    }
  }  Future<RestoDetailModel> detail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestoDetailModel.fromJson(json.decode(response.body));
    } else {
      throw NetworkError('Failed to load Restaurant Detail');
    }
  }
  Future<RestoSearchModel> search(String keyword) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$keyword"));
    if (response.statusCode == 200) {
      return RestoSearchModel.fromJson(json.decode(response.body));
    } else {
      throw NetworkError('Failed to load Restaurant List');
    }
  }

}
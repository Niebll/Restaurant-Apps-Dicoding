import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantdicoding/widget/resto_list.dart';

import '../model/restaurants_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<RestaurantsModel> parseRestaurant(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => RestaurantsModel.fromJson(json)).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height -
                    MediaQuery
                        .of(context)
                        .padding
                        .top,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context).loadString(
                        'assets/data/local_restaurant.json'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                      // final restoran = parseRestaurant(snapshot.data);
                        final RestaurantsModel restaurantsModel = RestaurantsModel.fromJson(jsonDecode(snapshot.data.toString()));
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.15,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Restaurants",
                                  style: TextStyle(fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Text(
                                  "List of all restaurants",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: RestoListWidget(
                              restaurantsModel: restaurantsModel
                      ),),],
                      );}
                      else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                ),
              ),
            )));
  }
}

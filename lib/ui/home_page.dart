import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantdicoding/data/bloc/restolist_bloc/restolist_bloc.dart';
import 'package:restaurantdicoding/ui/search_page.dart';
import 'package:restaurantdicoding/widget/resto_list.dart';

import '../data/bloc/restolist_bloc/restolist_state.dart';
import '../data/bloc/restolist_bloc/restolist_event.dart';
import '../data/model/restaurants_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RestoListBloc _restoListBloc = RestoListBloc();

  List<RestaurantsModel> parseRestaurant(String? json) {
    if (json == null) {
      return [];
    }

    final List parsed = jsonDecode(json);
    return parsed.map((json) => RestaurantsModel.fromJson(json)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restoListBloc.add(const GetRestoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocProvider(
        create: (_) => _restoListBloc,
        child: BlocBuilder<RestoListBloc, RestoListState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );

            } else if (state is Loaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Restaurants",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "List of all restaurants",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: RestoListWidget(restaurantsModel: state.restoList),
                  ),
                ],
              );
            } else if (state is Error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Text("Error");
            }
          },
        ),
      ),
    ))));
  }
}

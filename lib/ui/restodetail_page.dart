import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantdicoding/data/bloc/restodetail_bloc/restodetail_bloc.dart';


class RestoDetailPage extends StatefulWidget {
  final String restoId;

  const RestoDetailPage({Key? key, required this.restoId,})
      : super(key: key);

  @override
  State<RestoDetailPage> createState() => _RestoDetailPageState();
}

class _RestoDetailPageState extends State<RestoDetailPage> {

  RestodetailBloc _restodetailBloc = RestodetailBloc();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _restodetailBloc.add(GetRestoDetail(widget.restoId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _restodetailBloc,
      child: BlocBuilder<RestodetailBloc, RestodetailState>(
        builder: (context, state) {
          if (state is RestodetailInitial) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is RestodetailLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is RestodetailLoaded) {
            final data = state.restoDetail;
            return Scaffold(
              appBar: AppBar(
                title: Text(data.restaurant.name),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          image: DecorationImage(
                              image: NetworkImage("https://restaurant-api.dicoding.dev/images/medium/${data.restaurant.pictureId}"),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //name resto
                              Text(
                                data.restaurant.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              const Icon(Icons.star, size: 16),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                  data.restaurant.rating.toString(),
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on, size: 16),
                              Text(
                                  data.restaurant.city,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data.restaurant.description,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          if (data.restaurant.menus.foods.isNotEmpty)
                            const Text(
                              'Foods',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 16 * 2,
                            height: 34,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.restaurant.menus.foods.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue[300]),
                                  child: Center(
                                    child: Text(
                                      data.restaurant.menus.foods[index].name,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                );
                              },),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (data.restaurant.menus.drinks.isNotEmpty)
                            const Text(
                              'Drinks',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 16 * 2,
                            height: 34,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.restaurant.menus.drinks.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue[300]),
                                  child: Center(
                                    child: Text(
                                      data.restaurant.menus.drinks[index].name,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                );
                              },),
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );            }
          else if (state is RestodetailError) {
            return Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );

  }
}

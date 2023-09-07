import 'package:flutter/material.dart';

import '../model/restaurants_model.dart';

class RestoDetailPage extends StatefulWidget {
  final String restoId;
  final RestaurantsModel restaurantsModel;

  RestoDetailPage(
      {Key? key, required this.restoId, required this.restaurantsModel})
      : super(key: key);

  @override
  State<RestoDetailPage> createState() => _RestoDetailPageState();
}

class _RestoDetailPageState extends State<RestoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget
            .restaurantsModel.restaurants[int.parse(widget.restoId)].name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  image: DecorationImage(
                      image: NetworkImage(widget.restaurantsModel
                          .restaurants[int.parse(widget.restoId)].pictureId),
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
                        widget.restaurantsModel
                            .restaurants[int.parse(widget.restoId)].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 16),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                          widget.restaurantsModel
                              .restaurants[int.parse(widget.restoId)].rating
                              .toString(),
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
                          widget.restaurantsModel
                              .restaurants[int.parse(widget.restoId)].city,
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
                    widget.restaurantsModel
                        .restaurants[int.parse(widget.restoId)].description,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (widget.restaurantsModel
                          .restaurants[int.parse(widget.restoId)]
                          .menus
                          .foods.isNotEmpty)
                  const Text(
                    'Foods',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-16 * 2,
                    height: 34,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.restaurantsModel
                          .restaurants[int.parse(widget.restoId)]
                          .menus
                          .foods
                          .length,
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
                            widget.restaurantsModel
                                .restaurants[int.parse(widget.restoId)]
                                .menus.foods[index].name,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      );

                    },),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.restaurantsModel
                      .restaurants[int.parse(widget.restoId)]
                      .menus
                      .drinks.isNotEmpty)
                  const Text(
                    'Drinks',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-16 * 2,
                    height: 34,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.restaurantsModel
                          .restaurants[int.parse(widget.restoId)]
                          .menus
                          .drinks
                          .length,
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
                              widget.restaurantsModel
                                  .restaurants[int.parse(widget.restoId)]
                                  .menus.drinks[index].name,
                              style: const TextStyle(fontSize: 12, color: Colors.white),
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
    );
  }
}

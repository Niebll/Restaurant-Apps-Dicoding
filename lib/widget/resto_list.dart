import 'package:flutter/material.dart';
import 'package:restaurantdicoding/data/model/resto_model.dart';

import '../ui/restodetail_page.dart';

class RestoListWidget extends StatelessWidget {
  final RestoListModel restaurantsModel;

  const RestoListWidget({Key? key, required this.restaurantsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: restaurantsModel.restaurants.length,
        itemBuilder: (context, index) {
          var resto = restaurantsModel.restaurants[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          // Container()));
                          RestoDetailPage(restoId: resto.id.toString(),)));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 100,
              width: MediaQuery.of(context).size.width - 2 * 16,
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage("https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resto.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              resto.city,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              resto.rating.toString(),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantdicoding/data/bloc/restosearch_bloc/restosearch_bloc.dart';
import 'package:restaurantdicoding/data/model/restosearch_model.dart';
import 'package:restaurantdicoding/ui/restodetail_page.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final RestosearchBloc _restosearchListBloc = RestosearchBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchFocusNode.requestFocus();
    _restosearchListBloc.add(const GetRestosearchList(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Page"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.45)),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      _restosearchListBloc.add(const GetRestosearchList(''));
                    }
                    _restosearchListBloc.add(GetRestosearchList(value));
                  });
                },
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                focusNode: _searchFocusNode,
                controller: _searchController,
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      bottom: 8.0,
                    ),
                    border: InputBorder.none,
                    hintText: "Cari Restoran Favorit Kamu",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Icon(Icons.search),
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocProvider(
            create: (_) => _restosearchListBloc,
            child: BlocBuilder<RestosearchBloc, RestosearchState>(
              builder: (context, state) {
                if (state is RestosearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                } else if (state is RestosearchLoaded) {
                  return Expanded(
                    child: _searchResult(state.restosearchList),
                  );
                } else if (state is RestosearchError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Text("Error");
                }
              },
            ),
          ),
        ],
      ),
      );
  }
  Widget _searchResult(RestoSearchModel restosearchList) {
    if (restosearchList.restaurants.isEmpty) {
      return const Center(
        child: Text("Tidak ada hasil pencarian"),
      );
    } else {
      return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemCount: restosearchList.restaurants.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                  return RestoDetailPage(restoId: restosearchList.restaurants[index].id.toString(),);
                    },
                ));
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2)),

                child: Column(
                  children: [
                    Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restosearchList.restaurants[index].pictureId}",
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(restosearchList.restaurants[index].name),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,),
                        const Icon(
                          Icons.location_on,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(restosearchList.restaurants[index].city),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,),
                        const Icon(
                          Icons.star_rate_sharp,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(restosearchList.restaurants[index].rating.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

}

// bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantdicoding/data/api/api_repository.dart';
import 'package:restaurantdicoding/data/bloc/restolist_bloc/restolist_event.dart';
import 'package:restaurantdicoding/data/bloc/restolist_bloc/restolist_state.dart';

class RestoListBloc extends Bloc<RestoListEvent, RestoListState> {
  RestoListBloc() : super(Initial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<GetRestoList>((event, emit) async {
      emit(Loading());
      try {
        final mList = await apiRepository.fetchRestoList();
        emit(Loaded(restoList: mList));
      }catch (e){
        emit(const Error(message: "Couldn't fetch data. Is the device online?"));
      }
    });
  }

}

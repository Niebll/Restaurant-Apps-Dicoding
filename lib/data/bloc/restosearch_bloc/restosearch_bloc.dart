
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/api_repository.dart';

part 'restosearch_event.dart';
part 'restosearch_state.dart';

class RestosearchBloc extends Bloc<RestosearchEvent, RestosearchState> {
  RestosearchBloc() : super(RestosearchInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<RestosearchEvent>((event, emit) async {
      try {
        emit(RestosearchLoading());
        final mList = await apiRepository.fetchRestoSearch(event.props[0].toString());
        emit(RestosearchLoaded(mList));
      } catch (e) {
        emit(const RestosearchError("Couldn't fetch data. Is the device online? please check your connection"));
      }
    });
  }
}

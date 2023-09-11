
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/api_repository.dart';
import '../../model/restodetail_model.dart';

part 'restodetail_event.dart';
part 'restodetail_state.dart';

class RestodetailBloc extends Bloc<RestodetailEvent, RestodetailState> {
  RestodetailBloc() : super(RestodetailInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<RestodetailEvent>((event, emit) async {
      try {
        emit(RestodetailLoading());
        final mList = await apiRepository.fetchRestoDetail(event.props[0].toString());
        emit(RestodetailLoaded(restoDetail: mList));
      } catch (e) {
        emit(const RestodetailError(message: "Couldn't fetch data. Is the device online? please check your connection"));
      }
    });
  }
}

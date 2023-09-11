part of 'restodetail_bloc.dart';

abstract class RestodetailEvent extends Equatable {
  const RestodetailEvent();
}

class GetRestoDetail extends RestodetailEvent {
  final String id;

  const GetRestoDetail(this.id);

  @override
  List<Object> get props => [id];
}

part of 'restodetail_bloc.dart';

abstract class RestodetailState extends Equatable {
  const RestodetailState();
}

class RestodetailInitial extends RestodetailState {
  @override
  List<Object> get props => [];
}

class RestodetailLoading extends RestodetailState {
  @override
  List<Object> get props => [];
}

class RestodetailLoaded extends RestodetailState {
  final RestoDetailModel restoDetail;

  const RestodetailLoaded({required this.restoDetail});

  @override
  List<Object> get props => [restoDetail];
}

class RestodetailError extends RestodetailState {
  final String message;

  const RestodetailError({required this.message});

  @override
  List<Object> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:restaurantdicoding/data/model/resto_model.dart';

abstract class RestoListState extends Equatable {
  const RestoListState();

  @override
  List<Object> get props => [];
}

class Initial extends RestoListState {}

class Loading extends RestoListState {}

class Loaded extends RestoListState {
  final RestoListModel restoList;

  const Loaded({required this.restoList});
}

class Error extends RestoListState {
  final String message;

  const Error({required this.message});
}
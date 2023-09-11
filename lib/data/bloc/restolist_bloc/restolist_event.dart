//event bloc
import 'package:equatable/equatable.dart';

abstract class RestoListEvent extends Equatable {
  const RestoListEvent();

  @override
  List<Object> get props => [];
}
class GetRestoList extends RestoListEvent {
  const GetRestoList();
}
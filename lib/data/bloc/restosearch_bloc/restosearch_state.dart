part of 'restosearch_bloc.dart';

abstract class RestosearchState extends Equatable {
  const RestosearchState();
}

class RestosearchInitial extends RestosearchState {
  @override
  List<Object> get props => [];
}

class RestosearchLoading extends RestosearchState {
  @override
  List<Object> get props => [];
}

class RestosearchLoaded extends RestosearchState {
  final restosearchList;

  RestosearchLoaded(this.restosearchList);

  @override
  List<Object> get props => [restosearchList];
}

class RestosearchError extends RestosearchState {
  final String message;
  const RestosearchError(this.message);

  @override
  List<Object> get props => [message];
}

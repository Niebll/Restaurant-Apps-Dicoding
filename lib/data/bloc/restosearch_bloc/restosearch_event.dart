part of 'restosearch_bloc.dart';

abstract class RestosearchEvent extends Equatable {
  const RestosearchEvent();
}

class GetRestosearchList extends RestosearchEvent {
  final String  keyword;
  const GetRestosearchList(this.keyword);

  @override
  List<Object> get props => [keyword];
}

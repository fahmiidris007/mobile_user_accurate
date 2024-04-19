part of 'get_user_bloc.dart';

sealed class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => [];
}

final class GetUser extends GetUserEvent {}

class FilterByCity extends GetUserEvent {
  final List<String> cities;

  const FilterByCity(this.cities);

  @override
  List<Object> get props => [cities];
}

class SearchUser extends GetUserEvent {
  final String query;

  const SearchUser(this.query);

  @override
  List<Object> get props => [query];
}

class SortUsers extends GetUserEvent {
  final bool sortNameAscending;

  const SortUsers(this.sortNameAscending);

  @override
  List<Object> get props => [sortNameAscending];
}

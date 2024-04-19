part of 'get_city_bloc.dart';

sealed class GetCityEvent extends Equatable {
  const GetCityEvent();

  @override
  List<Object> get props => [];
}

final class GetCity extends GetCityEvent {}

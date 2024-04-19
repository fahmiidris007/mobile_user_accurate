part of 'get_city_bloc.dart';

sealed class GetCityState extends Equatable {
  const GetCityState();

  @override
  List<Object> get props => [];
}

final class GetCityInitial extends GetCityState {}

final class GetCityLoading extends GetCityState {}

final class GetCitySuccess extends GetCityState {
  final List<City> cities;

  const GetCitySuccess({required this.cities});

  @override
  List<Object> get props => [cities];
}

final class GetCityError extends GetCityState {
  final String message;

  const GetCityError({required this.message});

  @override
  List<Object> get props => [message];
}

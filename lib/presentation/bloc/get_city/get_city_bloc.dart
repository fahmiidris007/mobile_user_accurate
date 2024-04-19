import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/domain/entities/city.dart';
import 'package:mobile_user_accurate/domain/usecases/get_cities.dart';

part 'get_city_event.dart';
part 'get_city_state.dart';

class GetCityBloc extends Bloc<GetCityEvent, GetCityState> {
  GetCityBloc({required this.getCities}) : super(GetCityInitial()) {
    on<GetCity>(_onGetCity);
  }

  final GetCities getCities;

  Future<void> _onGetCity(GetCity event, Emitter<GetCityState> emit) async {
    emit(GetCityLoading());
    final result = await getCities.execute();
    result.fold((failure) => emit(GetCityError(message: failure.message)),
        (city) => emit(GetCitySuccess(cities: city)));
  }
}

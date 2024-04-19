import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/domain/usecases/get_users.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc({required this.getUsers}) : super(GetUserInitial()) {
    on<GetUser>(_onGetUser);
    on<FilterByCity>(_onFilterByCity);
    on<SearchUser>(_onSearchUser);
    on<SortUsers>(_onSortUsers);
  }

  final GetUsers getUsers;
  List<User> userList = [];

  Future<void> _onGetUser(GetUser event, Emitter<GetUserState> emit) async {
    emit(GetUserLoading());
    final result = await getUsers.execute();
    result.fold(
      (failure) => emit(
        GetUserError(message: failure.message),
      ),
      (user) {
        userList = user;
        emit(
          GetUserSuccess(users: user),
        );
        if (user.isEmpty) {
          emit(const GetUserEmpty(message: "Data not found"));
        }
      },
    );
  }

  Future<void> _onFilterByCity(
      FilterByCity event, Emitter<GetUserState> emit) async {
    if (state is GetUserSuccess) {
      final currentState = (state as GetUserSuccess);
      if (event.cities.isNotEmpty) {
        final resultFilter = userList
            .where((element) => event.cities
                .map((city) => city.toLowerCase())
                .contains(element.city.toLowerCase()))
            .toList();

        if (resultFilter.isNotEmpty) {
          final updatedState =
              currentState.copyWith(searchResult: resultFilter);
          emit(updatedState);
        } else {
          emit(const GetUserEmpty(message: "Data not found"));
        }
      } else {
        emit(GetUserSuccess(users: userList));
      }
    } else {
      emit(GetUserSuccess(users: userList));
    }
  }

  Future<void> _onSearchUser(
      SearchUser event, Emitter<GetUserState> emit) async {
    if (state is GetUserSuccess) {
      final currentState = (state as GetUserSuccess);
      if (event.query.isNotEmpty) {
        final resultSearch = userList
            .where((element) =>
                element.name.toLowerCase().contains(event.query.toLowerCase()))
            .toList();

        if (resultSearch.isNotEmpty) {
          final updatedState =
              currentState.copyWith(searchResult: resultSearch);
          emit(updatedState);
        } else {
          emit(const GetUserEmpty(message: "Data not found"));
        }
      } else {
        emit(GetUserSuccess(users: userList));
      }
    } else {
      emit(GetUserSuccess(users: userList));
    }
  }

  Future<void> _onSortUsers(SortUsers event, Emitter<GetUserState> emit) async {
    if (state is GetUserSuccess) {
      final currentState = state as GetUserSuccess;
      final sortedUsers = [...currentState.users];
      sortedUsers.sort((a, b) => event.sortNameAscending
          ? a.name.toLowerCase().compareTo(b.name.toLowerCase())
          : b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      emit(currentState.copyWith(
          searchResult: sortedUsers, isSorted: event.sortNameAscending));
    }
  }
}

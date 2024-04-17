import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/domain/usecases/get_users.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc({required this.getUsers}) : super(GetUserInitial()) {
    on<GetUser>(_onGetUser);
  }

  final GetUsers getUsers;

  Future<void> _onGetUser(GetUser event, Emitter<GetUserState> emit) async {
    emit(GetUserLoading());
    final result = await getUsers.execute();
    result.fold((failure) => emit(GetUserError(message: failure.message)),
        (user) => emit(GetUserSuccess(users: user)));
  }
}

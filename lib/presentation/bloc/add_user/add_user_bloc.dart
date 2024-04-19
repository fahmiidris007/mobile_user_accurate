import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';
import 'package:mobile_user_accurate/domain/usecases/add_user.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc({required this.addUser}) : super(AddUserInitial()) {
    on<PostUser>(_onPostUser);
  }

  final AddUser addUser;

  Future<void> _onPostUser(PostUser event, Emitter<AddUserState> emit) async {
    emit(AddUserLoading());
    final result = await addUser.execute(event.user);
    result.fold((failure) => emit(AddUserError(message: failure.message)),
        (user) => emit(AddUserSuccess(user: user)));
  }
}

part of 'add_user_bloc.dart';

sealed class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

final class AddUserInitial extends AddUserState {}

final class AddUserLoading extends AddUserState {}

final class AddUserSuccess extends AddUserState {
  final User user;
  const AddUserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class AddUserError extends AddUserState {
  final String message;
  const AddUserError({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'get_user_bloc.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}

final class GetUserLoading extends GetUserState {}

final class GetUserSuccess extends GetUserState {
  final List<User> users;

  const GetUserSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

final class GetUserError extends GetUserState {
  final String message;

  const GetUserError({required this.message});

  @override
  List<Object> get props => [message];
}

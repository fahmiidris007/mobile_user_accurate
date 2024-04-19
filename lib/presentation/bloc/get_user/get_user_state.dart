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
  final bool isNameSorted;

  const GetUserSuccess({required this.users, this.isNameSorted = false});

  GetUserSuccess copyWith({List<User>? searchResult, bool? isSorted}) {
    return GetUserSuccess(
        users: searchResult ?? users, isNameSorted: isSorted ?? isNameSorted);
  }

  @override
  List<Object> get props => [users];
}

final class GetUserEmpty extends GetUserState {
  final String message;

  const GetUserEmpty({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetUserError extends GetUserState {
  final String message;

  const GetUserError({required this.message});

  @override
  List<Object> get props => [message];
}

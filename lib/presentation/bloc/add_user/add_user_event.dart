part of 'add_user_bloc.dart';

sealed class AddUserEvent extends Equatable {
  const AddUserEvent();

  @override
  List<Object> get props => [];
}

final class PostUser extends AddUserEvent {
  final User user;

  const PostUser({required this.user});

  @override
  List<Object> get props => [user];
}

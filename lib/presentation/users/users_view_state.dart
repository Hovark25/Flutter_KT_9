import '../../domain/entities/user.dart';

sealed class UsersViewState {
  const UsersViewState();
}

final class UsersInitial extends UsersViewState {
  const UsersInitial();
}

final class UsersLoading extends UsersViewState {
  const UsersLoading();
}

final class UsersLoaded extends UsersViewState {
  UsersLoaded(List<User> users) : users = List<User>.unmodifiable(users);

  final List<User> users;
}

final class UsersFailure extends UsersViewState {
  const UsersFailure(this.message);

  final String message;
}

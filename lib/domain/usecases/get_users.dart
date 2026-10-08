import '../entities/user.dart';
import '../repositories/users_repository.dart';

class GetUsers {
  const GetUsers(this._repository);

  final UsersRepository _repository;

  Future<List<User>> call() {
    return _repository.getUsers();
  }
}

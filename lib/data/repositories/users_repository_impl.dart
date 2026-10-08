import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_remote_data_source.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._remoteDataSource);

  final UsersRemoteDataSource _remoteDataSource;

  @override
  Future<List<User>> getUsers() async {
    final models = await _remoteDataSource.fetchUsers();
    return models.map((model) => model.toEntity()).toList();
  }

  void dispose() {
    _remoteDataSource.dispose();
  }
}

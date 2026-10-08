import 'package:elementary/elementary.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

class UsersModel extends ElementaryModel {
  UsersModel(this._getUsers, {required void Function() onDispose})
      : _onDispose = onDispose;

  final GetUsers _getUsers;
  final void Function() _onDispose;

  Future<List<User>> getUsers() {
    return _getUsers();
  }

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }
}

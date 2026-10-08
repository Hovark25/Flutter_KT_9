import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';

import 'users_model.dart';
import 'users_page.dart';
import 'users_view_state.dart';

abstract interface class IUsersWidgetModel implements IWidgetModel {
  ValueListenable<UsersViewState> get state;

  Future<void> loadUsers();
}

class UsersWidgetModel extends WidgetModel<UsersPage, UsersModel>
    implements IUsersWidgetModel {
  UsersWidgetModel(UsersModel model) : super(model);

  final ValueNotifier<UsersViewState> _state =
      ValueNotifier<UsersViewState>(const UsersInitial());
  bool _isDisposed = false;

  @override
  ValueListenable<UsersViewState> get state => _state;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    loadUsers();
  }

  @override
  Future<void> loadUsers() async {
    if (_isDisposed || _state.value is UsersLoading) return;

    _state.value = const UsersLoading();

    try {
      final users = await model.getUsers();
      if (_isDisposed) return;
      _state.value = UsersLoaded(users);
    } catch (_) {
      if (_isDisposed) return;
      _state.value = const UsersFailure(
        'Не удалось загрузить пользователей\n'
        'Проверьте подключение к интернету и повторите попытку',
      );
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _state.dispose();
    super.dispose();
  }
}

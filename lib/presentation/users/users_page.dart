import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'users_view_state.dart';
import 'users_widget_model.dart';

class UsersPage extends ElementaryWidget<IUsersWidgetModel> {
  const UsersPage({
    super.key,
    required WidgetModelFactory<UsersWidgetModel> wmFactory,
  }) : super(wmFactory);

  @override
  Widget build(IUsersWidgetModel wm) {
    return ValueListenableBuilder<UsersViewState>(
      valueListenable: wm.state,
      builder: (context, state, child) {
        final isLoading = state is UsersInitial || state is UsersLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Пользователи'),
            actions: [
              IconButton(
                onPressed: isLoading ? null : wm.loadUsers,
                tooltip: 'Обновить',
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: _buildBody(wm, state),
        );
      },
    );
  }

  Widget _buildBody(IUsersWidgetModel wm, UsersViewState state) {
    if (state is UsersInitial || state is UsersLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is UsersFailure) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: wm.loadUsers,
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
      );
    }

    if (state is UsersLoaded) {
      final users = state.users;

      if (users.isEmpty) {
        return const Center(child: Text('Пользователей пока нет'));
      }

      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final user = users[index];

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Почта: ${user.email}'),
                    const SizedBox(height: 4),
                    Text('Номер: ${user.id}'),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'data/datasources/users_remote_data_source.dart';
import 'data/repositories/users_repository_impl.dart';
import 'domain/usecases/get_users.dart';
import 'presentation/users/users_model.dart';
import 'presentation/users/users_page.dart';
import 'presentation/users/users_widget_model.dart';

void main() {
  runApp(const UsersApp());
}

UsersWidgetModel createUsersWidgetModel(BuildContext context) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );
  final repository = UsersRepositoryImpl(UsersRemoteDataSource(dio));
  final model = UsersModel(
    GetUsers(repository),
    onDispose: repository.dispose,
  );

  return UsersWidgetModel(model);
}

class UsersApp extends StatelessWidget {
  const UsersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Пользователи',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const UsersPage(wmFactory: createUsersWidgetModel),
    );
  }
}

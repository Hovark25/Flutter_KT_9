import 'package:dio/dio.dart';

import '../models/user_model.dart';

class UsersRemoteDataSource {
  UsersRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<UserModel>> fetchUsers() async {
    final response = await _dio.get<List<dynamic>>('/users');
    final data = response.data;

    if (data == null) {
      throw const FormatException('Сервер вернул пустой ответ');
    }

    return data
        .map((item) => UserModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void dispose() {
    _dio.close(force: true);
  }
}

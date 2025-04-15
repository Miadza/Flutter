import 'package:dio/dio.dart';
import 'post_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );
      final List data = response.data;

      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка загрузки данных: $e');
    }
  }
}

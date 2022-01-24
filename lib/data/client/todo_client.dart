import 'dart:convert';

import 'package:http/http.dart';
import 'package:todo_app/assets/constants.dart';
import 'package:todo_app/data/models/todo.dart';

class TodoClient {
  final baseUrl = API_BASE;
  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + "/todos"));
      return todoFromJson(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> patchTodo(Map<String, dynamic> patchTodo, int? id) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$id"), body: patchTodo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Todo> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(Uri.parse(baseUrl + "/todos"), body: todoObj);
      return Todo.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await delete(Uri.parse(baseUrl + "/todos/$id"));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editTodo(int id, Map<String, String> updatedTodoObj) async {
    try {
      await patch(Uri.parse(baseUrl + "/todos/$id"), body: updatedTodoObj);
      return true;
    } catch (e) {
      return false;
    }
  }
}

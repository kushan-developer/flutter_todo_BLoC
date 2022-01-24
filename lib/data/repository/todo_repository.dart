import 'package:todo_app/data/client/todo_client.dart';
import 'package:todo_app/data/models/todo.dart';

class TodoRepository {
  final TodoClient todoCient;
  TodoRepository({required this.todoCient});

  Future<List<Todo>> fetchTodos() async {
    final todosRaw = await todoCient.fetchTodos();
    return todosRaw;
  }

  Future<bool> toggleCompletion(int? id, bool isCompleted) {
    final patchTodo = {"isCompleted": isCompleted.toString()};
    return todoCient.patchTodo(patchTodo, id);
  }

  Future<Todo> addTodo(String todoBody) async {
    final todoObj = {"todo": todoBody, "isCompleted": "false"};
    final todo = await todoCient.addTodo(todoObj);
    return todo;
  }

  Future<bool> deleteTodo(int id) async {
    return todoCient.deleteTodo(id);
  }

  Future<bool> editTodo(int id, String todoBody) async {
    final updatedTodoObj = {"todo": todoBody};
    return await todoCient.editTodo(id, updatedTodoObj);
  }
}

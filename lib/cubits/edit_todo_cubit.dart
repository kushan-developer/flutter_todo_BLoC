import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({required this.repository, required this.todosCubit})
      : super(EditTodoInitial());

  final TodoRepository repository;
  final TodosCubit todosCubit;

  void editTodo(Todo todo, String todoBody) {
    repository.editTodo(todo.id, todoBody).then((edited) {
      if (edited) {
        todo.todo = todoBody;
        todosCubit.updateTodoList();
        emit(EditTodoComplete());
      }
    });
  }

  void deleteTodo(Todo todo) {
    repository.deleteTodo(todo.id).then((isDeleted) {
      if (isDeleted) {
        todosCubit.deleteTodo(todo);
        emit(EditTodoComplete());
      }
    });
  }
}

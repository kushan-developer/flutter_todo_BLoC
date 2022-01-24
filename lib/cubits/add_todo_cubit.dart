import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit({required this.repository, required this.todosCubit})
      : super(AddTodoInitial());
  final TodoRepository repository;
  final TodosCubit todosCubit;

  void addTodo(String todoBody) {
    if (todoBody.isEmpty) {
      emit(AddTodoError("Todo cannot be empty!"));
      return;
    }
    emit(AddTodoPending());

    repository.addTodo(todoBody).then((todo) {
      todosCubit.addTodo(todo);
      emit(AddTodoComplete());
    });
  }
}

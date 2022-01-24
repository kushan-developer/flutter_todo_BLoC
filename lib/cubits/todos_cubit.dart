import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final TodoRepository repository;
  TodosCubit({required this.repository}) : super(TodosInitial());

  void fetchTodos() {
    Timer(const Duration(seconds: 2), () {
      repository.fetchTodos().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  void toggleCompletion(Todo todo) {
    repository
        .toggleCompletion(todo.id, !todo.isCompleted)
        .then((todoModified) {
      if (todoModified) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(todos: currentState.todos));
    }
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todosList =
          currentState.todos.where((t) => t.id != todo.id).toList();
      emit(TodosLoaded(todos: todosList));
    }
  }
}

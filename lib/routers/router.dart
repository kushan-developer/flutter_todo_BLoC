import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/assets/constants.dart';
import 'package:todo_app/cubits/add_todo_cubit.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/data/client/todo_client.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository/todo_repository.dart';
import 'package:todo_app/views/todos_add.dart';
import 'package:todo_app/views/todos_edit.dart';
import 'package:todo_app/views/todos_home.dart';

class TodoRouter {
  late TodoRepository repository;
  late TodosCubit todosCubit;

  TodoRouter() {
    repository = TodoRepository(todoCient: TodoClient());
    todosCubit = TodosCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: todosCubit,
                  child: const TodosHome(),
                ));
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EditTodoCubit(
                      repository: repository, todosCubit: todosCubit),
                  child: TodosEdit(
                    todo: todo,
                  ),
                ));
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddTodoCubit(
                      repository: repository, todosCubit: todosCubit),
                  child: TodosAdd(),
                ));
      default:
        return MaterialPageRoute(builder: (_) => const TodosHome());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/assets/constants.dart';
import 'package:todo_app/cubits/todos_cubit.dart';

class TodosHome extends StatefulWidget {
  const TodosHome({Key? key}) : super(key: key);

  @override
  State<TodosHome> createState() => _TodosHomeState();
}

class _TodosHomeState extends State<TodosHome> {
  @override
  void initState() {
    final todoProvider = BlocProvider.of<TodosCubit>(context);
    todoProvider.fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is! TodosLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final todos = (state).todos;
          return ListView(
              children: todos
                  .map((todo) => ListTile(
                        title: Text(todo.todo.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, EDIT_TODO_ROUTE,
                                      arguments: todo);
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                              onPressed: () async {
                                BlocProvider.of<TodosCubit>(context)
                                    .toggleCompletion(todo);
                              },
                              icon: const Icon(Icons.check),
                              color:
                                  todo.isCompleted ? Colors.green : Colors.grey,
                            ),
                          ],
                        ),
                      ))
                  .toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ADD_TODO_ROUTE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

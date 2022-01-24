import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class TodosEdit extends StatelessWidget {
  TodosEdit({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
      ),
      body: BlocListener<EditTodoCubit, EditTodoState>(
        listener: (context, state) {
          if (state is EditTodoComplete) {
            Navigator.pop(context);
            return;
          }
        },
        child: _body(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
        },
        child: const Icon(Icons.delete),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  Widget _body(context) {
    _textController.text = todo.todo;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: _textController,
            decoration: const InputDecoration(hintText: "Enter todo..."),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(onPressed: () {
            final todoBody = _textController.text;
            BlocProvider.of<EditTodoCubit>(context).editTodo(todo, todoBody);
          }, child: BlocBuilder<EditTodoCubit, EditTodoState>(
              builder: (context, state) {
            if (state is EditTodoPending) {
              return const CircularProgressIndicator();
            }
            return const Text("Save todo");
          }))
        ],
      ),
    );
  }
}

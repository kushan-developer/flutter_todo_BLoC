import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/assets/constants.dart';
import 'package:todo_app/cubits/add_todo_cubit.dart';

class TodosAdd extends StatelessWidget {
  TodosAdd({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is AddTodoComplete) {
            Navigator.pop(context);
            return;
          }
        },
        child: _body(context),
      ),
    );
  }

  Widget _body(context) {
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
            BlocProvider.of<AddTodoCubit>(context).addTodo(todoBody);
          }, child: BlocBuilder<AddTodoCubit, AddTodoState>(
              builder: (context, state) {
            if (state is AddTodoPending) {
              return const CircularProgressIndicator();
            }
            return const Text("Add todo");
          }))
        ],
      ),
    );
  }
}

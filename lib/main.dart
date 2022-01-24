import 'package:flutter/material.dart';
import 'package:todo_app/routers/router.dart';

void main() {
  runApp(TodoApp(router: TodoRouter()));
}

class TodoApp extends StatelessWidget {
  final TodoRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute);
  }
}

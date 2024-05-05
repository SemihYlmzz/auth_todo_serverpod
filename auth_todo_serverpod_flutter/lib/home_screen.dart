import 'package:auth_todo_serverpod_client/auth_todo_serverpod_client.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo>? todos;
  String? todoFailure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serverpod Example'),
      ),
      body: todoFailure != null
          ? Center(
              child: Text('Error occurred $todoFailure'),
            )
          : todos == null
              ? const Center(
                  child: Text('Loading...'),
                )
              : todos!.isEmpty
                  ? const Center(
                      child: Text('There is no todo.'),
                    )
                  : const Center(
                      child: Text('There is TODO!'),
                    ),
    );
  }
}

import 'package:auth_todo_serverpod_client/auth_todo_serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://$localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo>? todos;
  String? todoFailure;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    try {
      todos = await client.todo.readAllTodo();
      setState(() {});
    } catch (exception) {
      todoFailure = exception.toString();
    }
  }

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

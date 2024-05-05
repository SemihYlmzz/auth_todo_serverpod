import 'package:auth_todo_serverpod_client/auth_todo_serverpod_client.dart';
import 'package:auth_todo_serverpod_flutter/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'sign_in_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initializer = Initializer();
  await initializer.initializeServerpodClient();

  runApp(MyApp(
    client: initializer.client!,
    sessionManager: initializer.sessionManager!,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.client,
    required this.sessionManager,
  });
  final Client client;
  final SessionManager sessionManager;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    widget.sessionManager.addListener(() {
      print('auth result changed');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: widget.sessionManager.signedInUser != null
          ? const HomeScreen()
          : SignInScreen(
              client: widget.client,
              sessionManager: widget.sessionManager,
            ),
    );
  }
}

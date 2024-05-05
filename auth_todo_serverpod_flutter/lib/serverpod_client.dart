import 'package:auth_todo_serverpod_client/auth_todo_serverpod_client.dart';
import 'package:serverpod_auth_apple_flutter/serverpod_auth_apple_flutter.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class Initializer {
  static Initializer? _instance;

  factory Initializer() {
    _instance ??= Initializer._();
    return _instance!;
  }

  Initializer._();

  // Rest of the code...

  Client? client;
  SessionManager? sessionManager;

  Future<void> initializeServerpodClient() async {
    client ??= Client(
      'http://localhost:8080/',
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor();
    if (client == null) {
      return;
    }

    // The session manager keeps track of the signed-in state of the user. You
    // can query it to see if the user is currently signed in and get information
    // about the user.
    sessionManager ??= SessionManager(
      caller: client!.modules.auth,
    );
    if (sessionManager == null) {
      return;
    }
    await sessionManager!.initialize();
    return;
  }
}

import 'package:auth_todo_serverpod_client/auth_todo_serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen(
      {super.key, required this.client, required this.sessionManager});
  final Client client;
  final SessionManager sessionManager;

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    String? failure;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            onChanged: (value) => email = value,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            onChanged: (value) => password = value,
          ),
          ElevatedButton(
            onPressed: () async {
              print(sessionManager.signedInUser == null);
              final result = await client.modules.auth.email.authenticate(
                email,
                password,
              );
              if (!result.success) {
                failure = "Could not login";
              }

              if (result.userInfo == null) {
                failure = "User not found";
              }

              if (result.userInfo!.email == null) {
                failure = "Email not found";
              }

              if (result.keyId == null || result.key == null) {
                failure = "Not key or keyid found";
              }
              if (!context.mounted) return;

              if (result.failReason != null || failure != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to sign in: ${result.failReason}'),
                  ),
                );
                return;
              }
              await sessionManager.registerSignedInUser(
                result.userInfo!,
                result.keyId!,
                result.key!,
              );
            },
            child: const Text('Sign In'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: const Text('Navigate to Sign Up'),
          ),
        ],
      ),
    );
  }
}

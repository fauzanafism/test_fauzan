import 'package:flutter/material.dart';
import 'package:test_fauzan/ui/pages/login_page.dart';
import 'package:test_fauzan/ui/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: RegisterPage.route,
      routes: {
        RegisterPage.route: (context) => const RegisterPage(),
        LoginPage.route: (context) => const LoginPage(),
      },
    );
  }
}

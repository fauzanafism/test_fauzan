import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/data/api/api_service.dart';
import 'package:test_fauzan/provider/list_user_provider.dart';
import 'package:test_fauzan/provider/register_provider.dart';
import 'package:test_fauzan/ui/pages/home_page.dart';
import 'package:test_fauzan/ui/pages/login_page.dart';
import 'package:test_fauzan/ui/pages/register_page.dart';
import 'package:test_fauzan/ui/pages/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ListUserProvider>(
          create: (_) => ListUserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Test Fauzan App',
        initialRoute: Wrapper.route,
        routes: {
          Wrapper.route: (context) => const Wrapper(),
          RegisterPage.route: (context) => const RegisterPage(),
          LoginPage.route: (context) => const LoginPage(),
          HomePage.route: (context) => const HomePage(),
        },
      ),
    );
  }
}

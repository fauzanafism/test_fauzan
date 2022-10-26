import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/provider/home_provider.dart';
import 'package:test_fauzan/ui/pages/home_page.dart';
import 'package:test_fauzan/ui/pages/login_page.dart';
import 'package:test_fauzan/ui/pages/register_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, state, _) {
        try {
          state.getLoginInfo();
          if (state.isLogin) {
            try {
              state.getList();
              return const HomePage();
            } catch (_) {
              state.isLogin = false;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please login again')));
              return const LoginPage();
            }
          } else {
            return const RegisterPage();
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
          return const RegisterPage();
        }
      },
    );
  }
}

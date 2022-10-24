import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/provider/register_provider.dart';
import 'package:test_fauzan/ui/pages/home_page.dart';
import 'package:test_fauzan/ui/pages/register_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, state, _) {
        return (state.isLogin) ? const HomePage() : const RegisterPage();
      },
    );
  }
}

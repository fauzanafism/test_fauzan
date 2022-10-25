// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/provider/register_provider.dart';
import 'package:test_fauzan/ui/common/style.dart';
import 'package:test_fauzan/ui/common/widget.dart';
import 'package:test_fauzan/ui/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String route = '/register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          constraints: const BoxConstraints.expand(),
          child: const Image(
              image: AssetImage("assets/images/base_splash.png"),
              fit: BoxFit.cover),
        ),
        Center(
          child: Container(
            width: 279,
            height: 400,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Style.mainColor,
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Register",
                  style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(),
                CustomTextField(
                    hintText: 'Name',
                    isObscure: false,
                    controller: nameController),
                CustomTextField(
                    hintText: 'Email',
                    isObscure: false,
                    controller: emailController),
                CustomTextField(
                    hintText: 'Password',
                    isObscure: true,
                    controller: passController),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        emailController.text.contains('@') &&
                        passController.text.isNotEmpty &&
                        passController.text.length >= 6) {
                      var user = await Provider.of<RegisterProvider>(context,
                              listen: false)
                          .register(nameController.text, emailController.text,
                              passController.text);
                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Success')));
                        Navigator.pushNamed(context, LoginPage.route);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Register failed')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please check your form again')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Style.secondaryColor),
                  child: Text(
                    'Register',
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const Divider(),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.route);
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.mulish(color: Colors.white),
                    ))
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
  }
}

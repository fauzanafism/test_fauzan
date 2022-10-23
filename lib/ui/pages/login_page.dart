import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_fauzan/ui/common/style.dart';
import 'package:test_fauzan/ui/common/widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String route = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Image(image: AssetImage("assets/images/base_splash.png")),
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
                  "Login",
                  style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                    hintText: 'Email',
                    isObscure: false,
                    controller: emailController),
                CustomTextField(
                    hintText: 'Password',
                    isObscure: true,
                    controller: passController),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Style.secondaryColor),
                  child: Text(
                    'Login',
                    style: GoogleFonts.mulish(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const Divider(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register',
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
  }
}
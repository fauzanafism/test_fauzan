import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_fauzan/data/model/user_account.dart';
import 'package:test_fauzan/provider/home_provider.dart';
import 'package:test_fauzan/provider/login_provider.dart';
import 'package:test_fauzan/ui/common/style.dart';
import 'package:test_fauzan/ui/common/widget.dart';
import 'package:test_fauzan/ui/pages/home_page.dart';

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
    return Consumer<LoginProvider>(builder: (context, state, _) {
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
                    "Login",
                    style: GoogleFonts.mulish(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
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
                      if (emailController.text.isNotEmpty &&
                          emailController.text.contains('@') &&
                          passController.text.isNotEmpty) {
                        UserAccount? user = await state.login(
                            emailController.text, passController.text);
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success')));
                          Provider.of<HomeProvider>(context, listen: false)
                              .getList(user.data!.token);
                          Navigator.pushNamed(context, HomePage.route);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please check your form again')));
                      }
                    },
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
}

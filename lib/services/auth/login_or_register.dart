import 'package:chitchatappbymehdinathani/screens/login_page.dart';
import 'package:chitchatappbymehdinathani/screens/register_page.dart';
import 'package:flutter/material.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  // initially show the login screen
  bool showLoginPage = true;

// toggle between login and register page.
  void togglepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPageView(
        onTap: togglepages,
      );
    } else {
      return RigisterPageView(
        onTap: togglepages,
      );
    }
  }
}

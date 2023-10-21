import 'package:chitchatappbymehdinathani/components/custom_elevatedButon.dart';
import 'package:chitchatappbymehdinathani/components/custom_textfield.dart';
import 'package:chitchatappbymehdinathani/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPageView extends StatefulWidget {
  final Function() onTap;

  const LoginPageView({super.key, required this.onTap});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  //text controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final customSizedBox = const SizedBox(
    height: 20,
  );

  // sign in user
  void signinUser() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(_email.text, _password.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(
          child: Text("Chit Chat"),
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customSizedBox,
              //logo
              const Icon(
                Icons.chat,
                size: 80,
                color: Colors.amber,
              ),
              customSizedBox,
              //welcome text
              const Text("Welcome Back to your Chat space"),
              customSizedBox,
              //email textfield
              CustomTextField(
                controller: _email,
                hintText: "Email Address",
                obscureText: false,
              ),
              customSizedBox,
              // password textfield
              CustomTextField(
                controller: _password,
                hintText: "Password",
                obscureText: true,
              ),
              customSizedBox,
              //signin button
              CustomElevatedButton(
                onPressed: signinUser,
                buttonText: "Login",
              ),
              customSizedBox,
              //not a member register...
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

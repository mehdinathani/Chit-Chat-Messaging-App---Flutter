import 'package:chitchatappbymehdinathani/components/custom_elevatedButon.dart';
import 'package:chitchatappbymehdinathani/components/custom_textfield.dart';
import 'package:chitchatappbymehdinathani/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RigisterPageView extends StatefulWidget {
  final Function() onTap;
  const RigisterPageView({super.key, required this.onTap});

  @override
  State<RigisterPageView> createState() => _RigisterPageViewState();
}

class _RigisterPageViewState extends State<RigisterPageView> {
  //text controllers
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();
  final customSizedBox = const SizedBox(
    height: 20,
  );

  // sign up user
  void signUp() async {
    if (_password.text != _confirmpassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords didnt match!"),
        ),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      authService.signupWithEmailAndPassword(
        _email.text,
        _password.text,
      );
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
              const Text("Lets create an account on Chit Chat."),
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
              CustomTextField(
                controller: _confirmpassword,
                hintText: "Password",
                obscureText: true,
              ),
              customSizedBox,
              //signin button
              CustomElevatedButton(
                onPressed: signUp,
                buttonText: "Sign up",
              ),
              customSizedBox,
              //not a member register...
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login now!",
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

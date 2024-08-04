import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messengerapp/components/my_alert_dialogue.dart';
import 'package:messengerapp/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var passwordNotVisible = true;
  // sign up user
  void signUp(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => const MyAlertDialogue(title: 'Error', content: 'Passwords do not match', buttonText: 'ok')
      );
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  // get auth service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Icon(
                      Icons.message,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Let's get started",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 50),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: passwordNotVisible,
                      suffixIcon: IconButton(
                        icon: passwordNotVisible
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                        onPressed: () {
                          setState(() {
                            passwordNotVisible = !passwordNotVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: passwordNotVisible,
                      suffixIcon: IconButton(
                        icon: passwordNotVisible
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                        onPressed: () {
                          setState(() {
                            passwordNotVisible = !passwordNotVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    MyButton(onTap: () => signUp(context), text: 'Sign up'),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already a member?'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text('Login now',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

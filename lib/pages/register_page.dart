// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_login/components/my_button.dart';
import 'package:modern_login/components/square_tile.dart';
import '../components/my_textFields.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  //  sign users up
  void SignUpUser() async {
    // show a dialog like a loading ..
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //try sign in
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showErrorMessage("Password Don't Match!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // way two just show the message using new function
      showErrorMessage(e.code);
      // if (e.code == 'user-not-found') {
      //   // print('No user found for that email.');
      //   wrongEmailMessage();
      // } else if (e.code == 'wrong-password') {
      //   // print('Wrong password provided for that user.');
      //   wrongPasswordMessage();
      // }
    }
  }

//  create dialogs for email and password
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red[200],
            title: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // put a logo
                Icon(Icons.lock, size: 50),
                // here goes text -- hello again
                SizedBox(
                  height: 40,
                ),
                Text("Hello! Welcome.",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Fill Form Below to be Registered!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // username
                MyTextField(
                  controller: emailController,
                  textHint: 'Email',
                  ObsecureText: false,
                ),
                // password
                SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  textHint: 'Password',
                  ObsecureText: true,
                ),
                SizedBox(height: 20),
                // confirm password

                MyTextField(
                  controller: confirmpasswordController,
                  textHint: 'Confirm Password',
                  ObsecureText: true,
                ),
                SizedBox(height: 15),
                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: SignUpUser,
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or Continue With"),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),
                    const SizedBox(width: 20),
                    // google button
                    SquareTile(imagePath: 'lib/images/apple.png'),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Have an Account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now!",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:chat_appb/constants.dart';
import 'package:chat_appb/helper/show-snack-bar.dart';
import 'package:chat_appb/pages/chat_page.dart';
import 'package:chat_appb/pages/register_page.dart';
import 'package:chat_appb/widgets/custom_button.dart';
import 'package:chat_appb/widgets/customtext_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75),
                Image.asset(
                  'assets/image/chatimage.jpg',
                  alignment: Alignment.bottomCenter,
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chat Message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hinttext: 'Email',
                ),
                SizedBox(height: 16),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hinttext: 'Password',
                ),
                SizedBox(height: 16),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user-not-found');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'wrong-password');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },

                  text: 'LOGIN',
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        '  Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

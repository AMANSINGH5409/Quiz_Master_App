import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmasterapp/Pages/signinPage.dart';
import 'package:quizmasterapp/Services/auth.dart';
import 'package:quizmasterapp/Widgets/appBar.dart';

import '../Widgets/BlueButton.dart';
import 'HomePage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "", name = "";
  RegExp regExp = RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
  bool isLoading = false;

  AuthServices authServices = AuthServices();

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authServices.signUpEmailAndPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0.0,
        title: appBar(),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    TextFormField(
                      validator: (value) {
                        return (value!.isEmpty || value.length < 4)
                            ? "Enter Valid Username! (Min of 4 characters)"
                            : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Username",
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                        validator: (value) {
                          return value!.isNotEmpty
                              ? !regExp.hasMatch(value.toString())
                                  ? "Invalid EmailID!"
                                  : null
                              : "Enter EmailId!";
                        },
                        decoration: const InputDecoration(
                          hintText: "Email ID",
                        ),
                        onChanged: (val) {
                          email = val;
                        }),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      validator: (value) {
                        return (value!.isEmpty || value.length < 6)
                            ? "Set Valid Password! (Min of 6 characters)"
                            : null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    const SizedBox(height: 15.5),
                    GestureDetector(
                      onTap: () {
                        signUp();
                      },
                      child: blueBtn(context: context, label: "Sign Up"),
                    ),
                    const SizedBox(height: 15.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()));
                          },
                          child: const Text(
                            "SignIn",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 60.0)
                  ],
                ),
              ),
            ),
    );
    ;
  }
}

import 'package:autologic/constants/constants.dart';
import 'package:autologic/screen/createUser/signup.dart';
import 'package:autologic/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtext = TextEditingController();
  TextEditingController passwordtext = TextEditingController();
  late bool _loading = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Container(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  logo,
                  width: 300.0,
                  height: 300,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: emailtext,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your email";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passwordtext,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter your password";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                _loading
                    ? loading
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: BorderSide(color: Colors.red))),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.only(
                              left: 105.0,
                              right: 105.0,
                              top: 20.0,
                              bottom: 20.0,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            print(emailtext.text);
                            print(passwordtext.text);

                            await AuthService().signInEmail(
                                email: emailtext.text,
                                password: passwordtext.text);
                          }
                        },
                        child: Text("Login"),
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.red))),
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                        left: 85.0,
                        right: 85.0,
                        top: 20.0,
                        bottom: 20.0,
                      ))),
                  onPressed: () async {
                    Get.to(() => SignupScreen());
                  },
                  child: Text("New user SignUp here"),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

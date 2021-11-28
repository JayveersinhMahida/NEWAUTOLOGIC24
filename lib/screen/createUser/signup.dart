import 'package:autologic/constants/constants.dart';
import 'package:autologic/services/Database/database.dart';
import 'package:autologic/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late bool _loading = false;
  TextEditingController emailtext = TextEditingController();
  TextEditingController passwordtext = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    width: 280.0,
                    height: 250,
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  Text(
                    "Register yourself",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter your Name";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: mobile,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter your Mobile";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile No',
                      hintText: 'Enter Your Phone number',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: emailtext,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter your Email";
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
                            print(emailtext.text);
                            print(passwordtext.text);
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              try {
                                UserCredential dd = await AuthService()
                                    .signupwithEmail(
                                        email: emailtext.text.trim(),
                                        password: passwordtext.text.trim());
                                print(dd.user!.uid);

                                await Database(dd.user!.uid).updateuserData(
                                  emailid: dd.user!.email!,
                                  mobileNo: mobile.text.trim(),
                                  role: 'user',
                                  userName: name.text,
                                );

                                setState(() {
                                  _loading = false;
                                  Navigator.pop(context);
                                });
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  _loading = false;
                                });
                                print(e);
                              }
                            }
                          },
                          child: Text("SignUp"),
                        )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

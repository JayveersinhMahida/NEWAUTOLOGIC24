import 'package:autologic/screen/splash/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final controller = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoLogic24',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import 'package:autologic/screen/adminCheck/adminCheckScreen.dart';
import 'package:autologic/screen/select_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/login/login.dart';
import 'services/auth.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({Key? key}) : super(key: key);

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  final controller = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    print(controller.user.value);
    return Obx(
      () => controller.user.value == null
          ? LoginScreen()
          : controller.user.value!.email == "mahida.jayveerm.j@gmail.com"
              ? AdminScreen()
              : Home(),
    );
  }
}

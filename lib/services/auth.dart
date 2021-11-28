import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import 'Database/database.dart';

class AuthService extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var login = false.obs;
  var admin = false.obs;

  Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    print("AA check Kre che ......${user.value}");
    super.onInit();
    // print("fari check kr ${user.value!.email}");
  }

  Future signInEmail({required String email, required String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // _auth.signOut();

      return user;
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(middleText: "${e.message}");
    }
  }

  Future signOut() async {
    return await _auth.signOut();
  }

  Future currentUser() async {
    return _auth.currentUser;
  }

  Future<UserCredential> signupwithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print("Aa user che ${user.user!.uid}");

      return user;
    } on FirebaseAuthException catch (e) {
      print(e);
      Get.defaultDialog(content: Text(e.message!));
      throw e;
    }
  }
}

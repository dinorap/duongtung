import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app_v2/login/login_page.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/home_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  //email,pass,name...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => LoginPage());
    } else {
     Get.offAll(() => HomePage(email: user.email!));
      Get.back();
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "About user",
        "Account successfully created",
        backgroundColor: Colors.greenAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account created",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          "You have successfully registered",
          style: TextStyle(color: Colors.white),
        ),
      );
      _initialScreen(null);
    } catch (e) {
      Get.snackbar(
        "About user",
        "user message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
          "About Login",
          "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login Fail",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void logout() async {
    await auth.signOut();
  }

  void changePassword(String newPassword) async {
    try {
      await auth.currentUser!.updatePassword(newPassword);
      Get.snackbar(
          "Change Password",
          "Your password has been changed successfully.",
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar(
          "Change Password",
          "Failed to change password.",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Change Password Failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ));
    }
  }
  Future<bool> resetPassword(String email) async {
    bool resetSuccess = false;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Reset Password",
        "An email has been sent to $email to reset your password.",
        backgroundColor: Colors.greenAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
      resetSuccess = true;
    } catch (e) {
      Get.snackbar(
        "Reset Password",
        "Failed to send reset password email.",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Reset Password Failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    } finally {
      return resetSuccess;
    }
  }


  Future<bool> verifyPassword(String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _user.value!.email!, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}


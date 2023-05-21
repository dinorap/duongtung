import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app_v2/login/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/home_page.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController compasswordController = TextEditingController();
  List images = ["assets/g.png", "assets/t.png", "assets/f.png"];
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    compasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(


      backgroundColor: Color(0xFF262223),
      body: SingleChildScrollView(
        child: Column(
          children: [

           Container(
              width: w,
              height: h * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(990),
                image: DecorationImage(
                  image: AssetImage("assets/chatlogo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              width: w,
              height: h * 0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/mau2.png"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  children: [

                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDDC6B6),
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                        decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: '                NHẬP GMAIL CỦA BẠN',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDDC6B6),
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                        decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: '            NHẬP MẬT KHẨU CỦA BẠN',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDDC6B6),
                        borderRadius: BorderRadius.circular(0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: compasswordController,
                        obscureText: _obscureText,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                        decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: '                 NHẬP LẠI MẬT KHẨU',
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 20),
            GestureDetector(

              // Existing code for the register button

              child: Container(
                width: w * 0.5,
                height: h * 0.09,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                      image: AssetImage("assets/mau1.png"),
                      fit: BoxFit.cover,
                    )),
                child: Center(
                  child: Text("ĐĂNG KÍ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF262223),
                      )),
                ),
              ),
              onTap: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                String confirmPassword = compasswordController.text.trim();

                if (password == confirmPassword) {
                  AuthController.instance.register(email, password);
                } else {
                  Get.snackbar(
                    "Password incorrect",
                    "Please re-enter your password",
                    backgroundColor: Colors.redAccent,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 3),
                    titleText: Text(
                      "Password incorrect",
                      style: TextStyle(color: Colors.white),
                    ),
                    messageText: Text(
                      "Please re-enter your password",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

              },
            ),
            SizedBox(height: 10),
            RichText(
                text: TextSpan(
              text: " Have an account ? ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.to(() => LoginPage()),
            )),
            SizedBox(height: 20),


            // Text(
            //   "Sing up using one of the following methods",
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Colors.grey[700],
            //   ),
            // ),


          ],
        ),
      ),
    );
  }
}

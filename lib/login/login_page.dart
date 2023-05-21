import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app_v2/login/singup_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'ForgotPasswordPage.dart';
import 'auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
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
              height: h * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/mau2.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  SizedBox(height: h*0.1,),
                  CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 55,
                    backgroundImage: AssetImage("assets/chatlogo.png"), // logo
                  )
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  children: [
                    Text("CHAT BOT",
                      style: TextStyle(
                        color: Color(0xFFDDC6B6), // Silver color
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDDC6B6),
                        borderRadius: BorderRadius.circular(0), // Đổi giá trị này thành 0

                      ),
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                        decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(0), // Đổi giá trị này thành 0
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0), // Đổi giá trị này thành 0
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
                        color: Color(0xFFDDC6B6), // nền mật khẩu

                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscureText, // ẩn mk
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                        decoration: InputDecoration(

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0), // bo tròn các góc với bán kính là 0
                            borderSide: BorderSide(
                              color: Colors.white, // màu đường viền khi ấn vào textfield
                              width: 1.0, // độ dày đường viền
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0), // bo tròn các góc với bán kính là 0
                            borderSide: BorderSide(
                              color: Colors.white, // màu đường viền khi ấn vào textfield
                              width: 1.0, // độ dày đường viền
                            ),
                          ),
                          hintText: '            NHẬP MẬT KHẨU CỦA BẠN',

                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        RichText(
                            text: TextSpan(
                              text: "\nQUÊN MẬT KHẨU",
                              style: TextStyle(
                                  fontSize: 20,
                                color: Color(0xFFDDC6B6),
                                fontWeight: FontWeight.bold,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => ForgotPasswordPage()),
                            )),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                  AuthController.instance.login(email, password);
              },
              child: Container(
                width: w * 0.5,
                height: h * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    image: DecorationImage(
                      image: AssetImage("assets/mau1.png"),
                      fit: BoxFit.cover,
                    )),
                child: Center(
                  child: Text("ĐĂNG NHẬP",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF262223
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(height: 60),
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        text: " TẠO TÀI KHOẢN",
                        style: TextStyle(color: Colors.white, fontSize: 22,fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                      )
                    ]))
          ],
        ),
      ),
    );
  }
}





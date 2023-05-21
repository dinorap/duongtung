import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

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
              height: h * 0.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/mau2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 100),
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
                controller: _emailController,
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
                      color: Color(0xFFDDC6B6),
                      width: 8.0,
                    ),
                  ),
                  hintText: '                   NHẬP GMAIL CỦA BẠN',
                  hintStyle: TextStyle(
                    color: Color(0xFF262223), // Thay đổi màu chữ tại đây
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                bool resetSuccess = await AuthController.instance.resetPassword(_emailController.text);
                if (resetSuccess) {
                  Navigator.pop(context);
                }
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
                  child: Text("ĐẶT LẠI MÂT KHẨU",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF262223),
                      )),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

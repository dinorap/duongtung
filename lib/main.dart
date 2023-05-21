import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_app_v2/login/Splash_screen.dart';
import 'package:flutter_weather_app_v2/login/auth_controller.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value)=>Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return const GetMaterialApp(
      title: 'Weather',
      //home: SignUpPage(),
      //home: LoginPage(),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


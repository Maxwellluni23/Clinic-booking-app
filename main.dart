// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:dibrimak_mobile/Pages/home_page.dart';
import 'package:dibrimak_mobile/Pages/login.dart';
import 'package:dibrimak_mobile/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getcurrentUser() async {
    return auth.currentUser;
  }

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenWrapper(), // Use a custom SplashScreenWrapper widget
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  SplashScreenWrapperState createState() => SplashScreenWrapperState();
}

class SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    // Add any initialization code here if needed
    // You can display a logo or loading indicator during this time
    _loadScreen();
  }

  _loadScreen() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    getcurrentUser() async {
      return auth.currentUser;
    }

    await Future.delayed(
        Duration(seconds: 4)); // Simulate a 4-second splash screen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return FutureBuilder(
          future: getcurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Image(
                width: 500,
                height: 300,
                image: AssetImage('lib/Assets/Slide2.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

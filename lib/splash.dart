import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*@override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }*/

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutQuart;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender Predictor',
              style: GoogleFonts.quicksand(
                fontSize: 54,
                color: Color.fromARGB(255, 255, 0, 102),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Predicting genders with high accuracy !',
              style: GoogleFonts.raleway(
                  fontSize: 20, color: Colors.blueGrey[900]),
            ),
            SizedBox(height: 16),
            Image.network(
              'https://ouch-cdn2.icons8.com/Xac8QP72HcjXze3XIV8W16X_REKv463qpVMqkvhEjFs/rs:fit:368:368/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzY2/L2VhMjY2M2IzLTkz/ZmMtNDhlOC1hNGU0/LTNlYmVlNDc3ZDE3/YS5zdmc.png', // Replace with your image URL
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

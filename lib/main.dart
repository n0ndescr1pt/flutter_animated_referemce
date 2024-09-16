import 'package:flutter/material.dart';
import 'package:asdasdqweqweanimatin/capysta/screens/home/home_screen.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/home_screen.dart';

void main() {
  runApp(TeslaApp());
}

class TeslaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeslaScreen()),
                );
              },
              child: Text("Tesla app"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text("Capysta app"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MainAppPage extends StatelessWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
    );
  }
}

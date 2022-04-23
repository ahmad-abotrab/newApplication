import 'package:flutter/material.dart';

class DebtsScreen extends StatelessWidget {
  const DebtsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          )),
          Positioned(
              child: Container(
            decoration: BoxDecoration(color: Colors.grey),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ))
        ],
      ),
    );
  }
}

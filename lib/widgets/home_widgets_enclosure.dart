import 'package:flutter/material.dart';

class HomeWidgetsEnclosure extends StatelessWidget {
  HomeWidgetsEnclosure({Key? key, required this.child, this.width, this.height}) : super(key: key);

  double? height;
  double? width;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: width??double.infinity,
      height: height,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 10,
              offset: const Offset(0, 3),
            )
          ]
      ),

      child: child,

    );
  }
}
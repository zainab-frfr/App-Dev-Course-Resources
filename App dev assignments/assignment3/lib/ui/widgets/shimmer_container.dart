import 'package:flutter/material.dart';

class MyShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  const MyShimmerContainer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
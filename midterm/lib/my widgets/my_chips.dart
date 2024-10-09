import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyChips extends StatelessWidget {
  final List<String> payloadIds;

  const MyChips({super.key, required this.payloadIds});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: payloadIds.map((id) => returnChip(id)).toList(),
    );
    // ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: payloadIds.length,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: returnChip(payloadIds[index]),
    //     );
    //   },
    // );
  }
}

Chip returnChip(String payID) {
  return Chip(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    side: const BorderSide(color: Colors.transparent),
    elevation: 2,
    padding: const EdgeInsets.all(8),
    backgroundColor:
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    label: Text(
      payID,
      style: const TextStyle(fontSize: 10),
    ),
  );
}

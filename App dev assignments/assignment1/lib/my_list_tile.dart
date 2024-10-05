import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String network;
  final String jobTitle;
  final String company;
  final String location;
  final String onsiteOrHybrid;
  final String partOrFullTime;

  const MyListTile(
      {super.key,
      required this.network,
      required this.jobTitle,
      required this.company,
      required this.location,
      required this.onsiteOrHybrid,
      required this.partOrFullTime});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(network),
      title: Text(
        jobTitle,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(company),
          Text('$location . $onsiteOrHybrid . $partOrFullTime'),
        ],
      ),
    );
  }
}

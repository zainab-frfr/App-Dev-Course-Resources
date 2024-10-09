import 'package:flutter/material.dart';
import 'package:midterm/launch_model.dart';

class MyLaunchTile extends StatelessWidget {
  final Launch launch;
  const MyLaunchTile({super.key, required this.launch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1.2,
        child: InkWell(
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal:20 ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          launch.missionName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          launch.missionId
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
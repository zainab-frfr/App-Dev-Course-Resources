import 'package:flutter/material.dart';
import 'package:midterm/launch_model.dart';
import 'package:midterm/my%20widgets/my_chips.dart';
import 'package:midterm/my%20widgets/my_dropdown_button.dart';

class MyLaunchTile extends StatefulWidget {
  final Launch launch;
  const MyLaunchTile({super.key, required this.launch});

  @override
  State<MyLaunchTile> createState() => _MyLaunchTileState();
}

class _MyLaunchTileState extends State<MyLaunchTile> {
  bool _isMorePressed = false;

  void morePressed() {
    setState(() {
      _isMorePressed ? _isMorePressed = false : _isMorePressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: InkWell(
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.launch.missionName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (!_isMorePressed)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      widget.launch.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (_isMorePressed)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Wrap(children: [
                      Text(
                        widget.launch.description,
                        overflow: TextOverflow.clip,
                      ),
                    ]),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyDropDownButton(pressed: morePressed,),
                  ],
                ),
                Flexible(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: MyChips(payloadIds: widget.launch.payloadIds)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyDropDownButton extends StatelessWidget {
  final Function pressed;
  
  const MyDropDownButton({super.key, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pressed();
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 233, 231, 231)
        ),
        child:const Padding(
          padding: EdgeInsets.symmetric(vertical: 7,horizontal: 9),
          child:  Row(
            children: [
              Text(
                'More',
                style: TextStyle(
                  color: Color.fromARGB(255, 45, 161, 255),
                  fontWeight: FontWeight.bold
                ),
              ),
              Icon(Icons.arrow_downward, color: Colors.blue,)
            ],
          ),
        ),
      ),
    );
  }
}
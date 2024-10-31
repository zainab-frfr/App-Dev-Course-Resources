import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  final Function() onTap;
  
  const MyButton({super.key, required this.text, required this.bgColor, required this.textColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: (text != '0')? const CircleBorder(): RoundedRectangleBorder(borderRadius:  BorderRadius.circular(40)),
        elevation: 5,
        color: bgColor,
        child: InkWell(
          borderRadius: (text != '0') 
            ? BorderRadius.circular(100) // Circle shape radius
            : BorderRadius.circular(40),
          onTap: (){
            onTap();
          },
          child: SizedBox(
            height: MediaQuery.sizeOf(context).width * .18,
            width: (text != '0')? MediaQuery.sizeOf(context).width * .18 : MediaQuery.sizeOf(context).width *.41,
            child: Center(   
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    (text != '0')?text: '$text            ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      color: textColor,
                    ),
                  )),
            ),
          ),
        ));
  }
}

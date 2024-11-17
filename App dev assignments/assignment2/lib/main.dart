import 'package:assignment2/button.dart';
import 'package:assignment2/calculator_notifier.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); 
  runApp( 
    ChangeNotifierProvider(
      create: (_) => CalculatorNotifier(), 
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final List<String> text = ['AC','+/-','%','÷','7','8','9','×','4','5','6','−','1','2','3','+','0','.','='];
  final List<Color> bgColors = [Colors.grey, const Color.fromARGB(255, 58, 58, 58), const Color.fromARGB(255, 247, 156, 21)];
  final List<Color> textColors = [Colors.white, Colors.black];

  @override
  Widget build(BuildContext context) {
    String result = context.watch<CalculatorNotifier>().result;
    String numOne = context.watch<CalculatorNotifier>().numOneDisplay;
    String operator = context.watch<CalculatorNotifier>().operation;
    String numTwo = context.watch<CalculatorNotifier>().numTwoDisplay;

    String prevResultDisplay = context.watch<CalculatorNotifier>().prevResultDisplay;
    String prevNumOneDisplay = context.watch<CalculatorNotifier>().prevNumOneDisplay;
    String prevNumTwoDisplay = context.watch<CalculatorNotifier>().prevNumTwoDisplay;
    String prevOperator = context.watch<CalculatorNotifier>().prevOperator;

    String morePrevResultDisplay = context.watch<CalculatorNotifier>().morePrevResultDisplay;
    String morePrevNumOneDisplay = context.watch<CalculatorNotifier>().morePrevNumOneDisplay;
    String morePrevNumTwoDisplay = context.watch<CalculatorNotifier>().morePrevNumTwoDisplay;
    String morePrevOperator = context.watch<CalculatorNotifier>().morePrevOperator;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15,10,10,50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded( 
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          (morePrevNumOneDisplay != "" && morePrevNumTwoDisplay != "" && morePrevResultDisplay != "" && morePrevOperator != "")
                          ?"$morePrevNumOneDisplay $morePrevOperator $morePrevNumTwoDisplay = $morePrevResultDisplay" 
                          :"",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 150, 147, 147)
                          ),
                        ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded( 
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          (prevNumOneDisplay != "" && prevNumTwoDisplay != "" && prevResultDisplay != "" && prevOperator != "")
                          ?"$prevNumOneDisplay $prevOperator $prevNumTwoDisplay = $prevResultDisplay"
                          :"" ,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 150, 147, 147)
                          ),
                        ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded( 
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          "$numOne $operator $numTwo" ,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 150, 147, 147)
                          ),
                        ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          result,
                          style: TextStyle(
                            fontSize: (result == "Cannot divide by Zero")? 30 : 60,
                            color: Colors.white
                          ),
                        ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              ExtendedWrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                maxLines: 5,
                children: text.asMap().entries.map( // asMap creates a map jahan an index is the key and the value is text k under k elements
                  (entry){
                    int index = entry.key;
                    String text = entry.value;

                    return MyButton(
                      text: text, 
                      bgColor: (index == 0 || index ==1 || index ==2)? bgColors[0]
                              :(index == 3 || index ==7 || index ==11 || index == 15 || index == 18)? bgColors[2]
                              :bgColors[1] , 
                      textColor: (index == 0 || index ==1 || index ==2)? textColors[1]
                              : textColors[0],
                      onTap: (index == 0 )? (){clearPressed(context);}
                              :(index ==1 )? (){changeSign(context);}
                              :(index == 3 || index ==7 || index ==11 || index == 15)? (){operatorPressed(context, text);}
                              : ( index == 18)? (){equalPressed(context);}
                              : (index == 17)? (){ addDecimal(context);}
                              : (index ==2) ? (){percentagePressed(context);}
                              :(){numberPressed(context, text);} ,

                    );
                  }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void numberPressed(BuildContext context, String num){
  context.read<CalculatorNotifier>().numberPressed(int.parse(num));
}

void operatorPressed(BuildContext context, String op){
  context.read<CalculatorNotifier>().operation = op;
}

void equalPressed(BuildContext context){
  context.read<CalculatorNotifier>().equalPressed();
}

void clearPressed(BuildContext context){
  context.read<CalculatorNotifier>().clearPressed();
}

void percentagePressed(BuildContext context){
  context.read<CalculatorNotifier>().percentage();
}

void changeSign(BuildContext context){
  context.read<CalculatorNotifier>().changeSign();
}

void addDecimal(BuildContext context){
  context.read<CalculatorNotifier>().decimalAdded();
}

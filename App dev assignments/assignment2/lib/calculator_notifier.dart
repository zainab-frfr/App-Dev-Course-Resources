import 'dart:math';

import 'package:flutter/material.dart';

/*
  1. boolean that tells kub pehla number likhna kub dosra
  2. jub operator pressed tou just store
  3. perform calculation when equal to pressed or when operator pressed after second number

*/

class CalculatorNotifier extends ChangeNotifier {

  String numOneDisplay ="";
  String numTwoDisplay = "";

  double _numOne = 0;
  double _numTwo = 0;
  bool _addToNumOne = true;

  double _result = 0;
  String _resultToDisplay = "";

  String _operation = "";

  bool _decimalAddedBoolean = false;
  int _exponent = 1;

  double get numOne => _numOne;
  double get numTwo => _numTwo;
  String get result => _resultToDisplay;
  String get operation => _operation;

  void storeStringDisplayNumber(double toStore, bool result){
    if(!result){
      if(_addToNumOne){
        if(_checkIfInteger(_numOne)){
          numOneDisplay = _returnInteger(_numOne);
        }else{
          numOneDisplay = _numOne.toString();
        }
      }else{
        if(_checkIfInteger(_numTwo)){
          numTwoDisplay = _returnInteger(_numTwo);
        }else{
          numTwoDisplay = _numTwo.toString();
        }
      }
    }else{
      if(_checkIfInteger(_result)){
          _resultToDisplay = _returnInteger(_result);
        }else{
          _resultToDisplay = _result.toString();
        }
    }

  }

  void numberPressed(int num){
    // if( _operation == "" && _numTwo == 0.0 && _numOne != 0.0){ //the case where you enter a number seedha after pressing equal to 
    //   clearPressed();
    // }
    if (_addToNumOne){
      if(!_decimalAddedBoolean){ //decimal say pehlay
        _numOne = (_numOne>=0)? (_numOne * 10) + num : (_numOne * 10) - num;
      }else {
        _numOne = (_numOne>=0)? _numOne + (num / pow(10, _exponent)) : _numOne - (num / pow(10, _exponent));
        _exponent++;
      }
      // print(_numOne);
      if(_decimalAddedBoolean && num == 0){
        numOneDisplay += '0';
      }else{
        storeStringDisplayNumber(_numOne, false);
      }
    }else{
      if(!_decimalAddedBoolean){
        _numTwo = (_numTwo>=0)? (_numTwo * 10) + num : (_numTwo * 10) - num;
      }else{
        _numTwo = (_numTwo>=0)? _numTwo + (num / pow(10, _exponent)) : _numTwo - (num / pow(10, _exponent));
        _exponent++;
      }
      if(_decimalAddedBoolean && num == 0){
        numTwoDisplay += '0';
      }else{
        storeStringDisplayNumber(_numTwo, false);
      }
    }
    notifyListeners();
  }

  set operation(String op) {
    _resetDecimalVariables();
    if(_operation != ""){
      equalPressed();
    }
    _operation = op;
    _addToNumOne = !_addToNumOne; //jab bhi operator pressed tou change value of boolean
    notifyListeners();
  }

  void equalPressed(){
    _resetDecimalVariables();
    switch (_operation){
      case '+':
        _add();
        break;
      case '−':
        _subtract();
        break;
      case '×':
        _multiply();
        break;
      case '÷':
        _divide();
        break;
      case '%':
        _modulo();
        break;
    }

    int decPlacesInresult = _checkNumberOfDecimalPlaces(_result);
    
    if(decPlacesInresult > 9){
      _resultToDisplay = _result.toStringAsFixed(9);
    } else if(decPlacesInresult == 1){
      storeStringDisplayNumber(_result, true);
    }
    else{
      _resultToDisplay = _result.toString();
    }

    numOneDisplay = _resultToDisplay;
    numTwoDisplay = "";

    _numOne = _result;
    _numTwo = 0;
    _addToNumOne = !_addToNumOne;
    _operation = "";
    notifyListeners();
  }

  void _add() {
    _result = _numOne + _numTwo;
  }

  void _subtract(){
    _result = _numOne - _numTwo;
  }

  void _multiply(){
    _result = _numOne * _numTwo;
  }

  void _divide(){
    if(_numTwo != 0 ){
      _result = _numOne / _numTwo;
    } else {
      _reset();
      _resultToDisplay = "Cannot divide by Zero";
    }
  }

  void _modulo(){
    if(_numTwo != 0 ){
      _result = _numOne % _numTwo;
    } else {
      _reset();
      _resultToDisplay = "Cannot divide by Zero";
    }
  }

  void _reset(){
    _numOne = 0;
    _numTwo = 0;
    _result = 0;
    _operation = "";
  }

  void clearPressed(){
    _resetDecimalVariables();
    _reset();
    _resultToDisplay = "";
    numOneDisplay = "";
    numTwoDisplay = "";
    _addToNumOne = true;
    notifyListeners();
  }

  void changeSign(){
    if(_addToNumOne){
      _numOne = -_numOne;
      storeStringDisplayNumber(_numOne, false);
    }else{
      _numTwo = -_numTwo;
      storeStringDisplayNumber(_numTwo, false);
    }
    notifyListeners();
  }

  int _checkNumberOfDecimalPlaces(double toCheck){
    String str = toCheck.toString();
    if(str.contains('.')){
      String checking = str.split('.')[1];
      return checking.length;
    }else{
      return 0;
    }
  }

  bool _checkIfInteger(double toCheck){
    String str = toCheck.toString();
    if(str.contains('.')){
      String checking = str.split('.')[1];
      if(checking.length == 1 && checking == '0'){
        return true;
      }else{
        return false;
      }
    }else{
      return true;
    }
  }

  String _returnInteger(double toConvert){
    return toConvert.toString().split('.')[0];
  }

  void decimalAdded(){
    if(_addToNumOne){
      numOneDisplay += '.';
    }else{
      numTwoDisplay += '.';
    }
    _decimalAddedBoolean = true;
    notifyListeners();
  }

  void _resetDecimalVariables(){
    if(_decimalAddedBoolean){
      _decimalAddedBoolean = false;
      _exponent = 1;
    }
  }

}

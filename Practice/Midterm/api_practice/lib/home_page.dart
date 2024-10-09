import 'dart:convert';

import 'package:api_practice/my_user_tile.dart';
import 'package:api_practice/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> users;
  bool _hasFetched = false;

  Future<void> getUsers() async{
    Response apiResponse = await http.get(Uri.parse('https://randomuser.me/api/?results=10'));

    if (apiResponse.statusCode == 200){
      Map<String,dynamic> decoded = jsonDecode(apiResponse.body);
      List jsonUsers = decoded['results'];

      users = jsonUsers.map((user) => User.fromJson(user)).toList();

      setState(() {
        _hasFetched = true;
      });

    }else{
      users = [];
      throw Exception('Problem in Fetching Data');
    }
  }

  @override
  void initState() {
    getUsers();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(_hasFetched){
      return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User userItem =  users[index];

            return MyUserTile(user: userItem,);
            
          }
      );
    }
    else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
  }

}
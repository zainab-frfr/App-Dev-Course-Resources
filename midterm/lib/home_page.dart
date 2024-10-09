import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:midterm/launch_model.dart';
import 'package:midterm/my_launch_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Launch> launches;
  bool _hasFetched = false;

  Future<void> getUsers() async{

    Response apiResponse = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

    if (apiResponse.statusCode == 200){
      List<dynamic> decoded = jsonDecode(apiResponse.body);
      //List jsonUsers = decoded['results'];

      launches = decoded.map((launch) => Launch.fromJson(launch)).toList();

      setState(() {
        _hasFetched = true;
      });

    }else{
      launches = [];
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
          itemCount: launches.length,
          itemBuilder: (context, index) {
            Launch curLaunch = launches[index];
            return MyLaunchTile(
              launch: curLaunch
            );
            
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
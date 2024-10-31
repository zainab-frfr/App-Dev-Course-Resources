import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_bloc/home_page.dart';
import 'package:mid_bloc/state_management/bloc_dummy.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 47, 126, 97),
          title: const Text(
            'Space Missions',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: BlocProvider(
        create: (context) => LaunchBloc()..add(FetchLaunches()),
        child:  const MyHomePage()
      )
      ),
    );
  }
}

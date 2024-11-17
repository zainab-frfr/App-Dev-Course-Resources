import 'package:assignment3/bloc/bloc.dart';
import 'package:assignment3/ui/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset('assets/images/news_icon.jpg'),
            ),
          ],
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Headline News', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Read Top News Today')
            ],
          ),
        ),
        body: BlocProvider(
        create: (context) => NewsBloc()..add(FetchNews()),
        child:  const MyHomePage()
      )
      ),
    );
  }
}

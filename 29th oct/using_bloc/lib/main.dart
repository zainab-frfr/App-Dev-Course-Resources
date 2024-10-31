import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc/bloc_dummy.dart';
//import 'package:using_bloc/home_page.dart';
import 'package:using_bloc/product_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(),
        useMaterial3: false,

      ),
      home: BlocProvider(
        create: (context) => ProductBloc()..add(FetchProducts()),
        child:  const ProductScreen()
      )
    );
  }
}

import 'dart:convert';
import 'package:apicall/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Post> _post = [];
  bool isLoading = true;

  

  @override
  void initState() {
    // TODO: implement initState
    fetchAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _post.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${index + 1}'),
                      trailing: const Text('end'),
                      title: Text(_post[index].title),
                      subtitle: Text('$_post[index].id}'),
                    );
                  },
                ),
        )
            ));
  }
}

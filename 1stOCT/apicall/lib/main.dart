import 'dart:convert';
import 'package:apicall/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<List<Post>> fetchAllPosts() async { //decodes json http response to Post model that we created below 
    // final response = await 
    //   http.get(Uri.parse('https://www.jsonplaceholder.org/posts'));

    final response = await http.get(Uri.parse('https://jsonplaceholder.org/posts'));


    if (response.statusCode == 200) {
      //all okay data araha api say
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: fetchAllPosts(), 
            builder: (context, snap){
              if(snap.hasData){
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${index + 1}'),
                      trailing: const Text('end'),
                      title: Text((snap.data as List<Post>)[index].title),
                      subtitle: Text('${(snap.data as List<Post>)[index].id}'),
                    );
                  });

              }else if(snap.hasError){
                return const Text('Error!!!!!!!!');
              }

              return const Center(child: Text('Found Nothing'),);
            }
          ),
        )
        
      ),
    );
  }
}


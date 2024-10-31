import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class PostNotifier extends ChangeNotifier{
  List<Post> _post = [];
  bool _dataFetched = false;

  List<Post> get post => _post;
  bool get dataFetched => _dataFetched;

  void fetchPosts() async{
    
    _dataFetched = false; 
    notifyListeners();
    
    final response = await http.get(Uri.parse('https://jsonplaceholder.org/posts'));
     if (response.statusCode == 200) {
       List jsonResponse = jsonDecode(response.body);
       _post =  jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
    _dataFetched = true;
    notifyListeners();
  }
}
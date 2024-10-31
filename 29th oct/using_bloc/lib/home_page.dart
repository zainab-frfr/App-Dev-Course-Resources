import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:using_bloc/model.dart';
import 'package:using_bloc/my_product_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ProductsModel> products;
  bool _hasFetched = false;

  Future<void> getProducts() async{
    Response apiResponse = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (apiResponse.statusCode == 200){
      Map<String,dynamic> decoded = jsonDecode(apiResponse.body);
      List jsonProducts = decoded['products'];

      products = jsonProducts.map((product) => ProductsModel.fromJson(product)).toList();

      setState(() {
        _hasFetched = true;
      });

    }else{
      products = [];
      throw Exception('Problem in Fetching Data');
    }
  }

  @override
  void initState() {
    getProducts();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(_hasFetched){
      return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            ProductsModel productItem =  products[index];

            return MyProductTile(product: productItem,);
            
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
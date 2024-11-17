import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:using_bloc/model.dart';
import 'package:http/http.dart' as http;

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

//Bloc state

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductsModel> products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String error;
  ProductError(this.error);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()){
    on<FetchProducts>(onFetchProducts);
  }

  Future<void> onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      List<ProductsModel> products = await getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

Future<List<ProductsModel>> getProducts() async {
  List<ProductsModel> products = [];

  Response apiResponse =
      await http.get(Uri.parse('https://dummyjson.com/products'));

  if (apiResponse.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(apiResponse.body);
    List jsonProducts = decoded['products'];

    products =
        jsonProducts.map((product) => ProductsModel.fromJson(product)).toList();
  } else {
    products = [];
  }

  return products;
}

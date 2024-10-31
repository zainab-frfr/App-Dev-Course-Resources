import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc/bloc_dummy.dart';
import 'package:using_bloc/model.dart';
import 'package:using_bloc/my_product_tile.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  ProductsModel productItem = state.products[index];

                  return MyProductTile(
                    product: productItem,
                  );
                });
          } else if (state is ProductError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text('error fetching state'),
            );
          }
        }));
  }
}

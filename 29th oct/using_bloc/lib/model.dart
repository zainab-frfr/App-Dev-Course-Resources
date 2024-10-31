class ProductsModel {
  final String title;
  final String description;
  final String price;
  final String thumbnail;

  ProductsModel({
    required this.title, 
    required this.description, 
    required this.price, 
    required this.thumbnail, 
});

  factory ProductsModel.fromJson(Map<String, dynamic> product){
    return ProductsModel(
      title: product['title'],
      description: product['description'],
      price: '${product['price']}',
      thumbnail: product['thumbnail']
    );
  }
}
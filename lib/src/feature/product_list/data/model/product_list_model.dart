class ProductList {
  List<Product>? products;

  ProductList({this.products});

  factory ProductList.fromJson(dynamic json) => ProductList(
        products: List<Product>.from(
          json.map(
            (x) => Product.fromJson(x),
          ),
        ),
      );
}

class Product {
  int? id;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  int? userId;

  Product({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        userId: json["userId"],
      );

  factory Product.fromModel(ProductWithQuantity product) => Product(
        id: product.id,
        title: product.title,
        thumbnail: product.thumbnail,
        userId: product.userId,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "thumbnail": thumbnail,
        "userId": userId,
      };
}

class ProductWithQuantity {
  final int? id;
  final String? title;
  final String? thumbnail;
  final int? userId;
  int? quantity;

  ProductWithQuantity({
    this.id,
    this.title,
    this.thumbnail,
    this.userId,
    this.quantity = 0,
  });

  factory ProductWithQuantity.fromJson(Map<String, dynamic> json) =>
      ProductWithQuantity(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        userId: json["userId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "userId": userId,
        "quantity": quantity,
      };
}

class Product {
  int id;
  int article;
  String title;
  double price;
  String photo;
  String category;
  int salePrice;
  int sale;

  Product(
      {required this.id,
      required this.article,
      required this.title,
      required this.price,
      required this.photo,
      required this.category,
      required this.salePrice,
      required this.sale});

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
        id: int.parse(json['id'].toString()),
        article: int.parse(json['article'].toString()),
        title: json['title'].toString(),
        price: double.parse(json['price'].toString()),
        photo: json['photo'].toString(),
        category: json['category'].toString(),
        salePrice: int.parse(json['saleprice'].toString()),
        sale: int.parse(json['sale'].toString()),);
  }

  Map<String, dynamic> toDatabaseJson() => {
        'id': this.id,
        'article': this.article,
        'title': this.title,
        'price': this.price,
        'photo': this.photo,
        'category': this.category,
        'saleprice': this.salePrice,
        'sale': this.sale
      };
}

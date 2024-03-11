class Products {
  final int id;
  final String title;
  final double price;
  int quantity;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
      'description':description,
      'category':category,
      'rating':rating.toJson(),
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']), quantity: json['quantity'] ?? 1,
    );
  }

  void incrementQuantity() {}
}

class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'rate':rate,
      'count':count,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}

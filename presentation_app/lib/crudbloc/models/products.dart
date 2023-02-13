class Products{
  int id;
  String title;
  double price;
  String? category;
  String? description;
  String image;

  Products({
    required this.id,
    required this.title,
    required this.price,
    this.category,
    this.description,
    required this.image,
  });

  factory Products.fromJson(Map<String, dynamic> data){
    return Products(
        id: data['id'],
        title: data['title'],
        price: double.parse(data['price'].toString()),
        description: data['description'],
        image: data['image'],
        category: data['category']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }


}
import 'package:presentation_app/crudbloc/models/products.dart';

class UpdateProducts{
  final Products product;
  final List<Products> products;

  UpdateProducts(this.product, this.products);
}
import 'package:presentation_app/crudbloc/models/products.dart';

class UpdateProducts{
  final Products product;
  final List<Products> products;
  final int productIndex;

  UpdateProducts(this.product, this.products, this.productIndex);
}
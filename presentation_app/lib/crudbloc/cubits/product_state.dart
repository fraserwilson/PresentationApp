import 'package:equatable/equatable.dart';
import 'package:presentation_app/crudbloc/models/products.dart';


abstract class ProductState extends Equatable {}

class LoadingState extends ProductState {
  @override
  List<Object> get props => [];
}
class LoadedState extends ProductState {
  LoadedState(this.products);

  final List<Products> products;

  @override
  List<Object> get props => [products];
}

class AddedState extends ProductState{
  AddedState(this.products);
  final List<Products> products;

  @override
  List<Object> get props => [products];

}

class DeletedState extends ProductState{
  DeletedState(this.message);
  final bool message;

  @override
  List<Object> get props => [message];

}

class UpdatedState extends ProductState{
  UpdatedState(this.message);
  final String message;

  @override
  List<Object> get props => [message];

}

class ErrorState extends ProductState {
  @override
  List<Object> get props => [];
}
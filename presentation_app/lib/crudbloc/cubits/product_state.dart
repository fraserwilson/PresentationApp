import 'package:equatable/equatable.dart';
import 'package:presentation_app/crudbloc/models/products.dart';

class MainProductState extends Equatable{
  final List<Products>? products;

  const MainProductState({
    this.products,
  });

  MainProductState copyWith({
    List<Products>? products,
  }) {
    return MainProductState(
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [products];

}

abstract class ProductState extends Equatable {
  final MainProductState mainProductState;

  const ProductState(this.mainProductState);

  @override
  List<Object?> get props => [mainProductState];
}

class InitialState extends ProductState{
  InitialState(): super(MainProductState());
}

class LoadingState extends ProductState {
   LoadingState(super.mainProductState);

}
class LoadedState extends ProductState {
  LoadedState(super.mainProductState);

}

class ErrorState extends ProductState {
  final String error;

  ErrorState(super.mainProductState, this.error);


}
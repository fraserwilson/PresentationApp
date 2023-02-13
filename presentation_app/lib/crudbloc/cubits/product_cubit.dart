
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/cubits/product_state.dart';
import 'package:presentation_app/crudbloc/models/products.dart';

import '../repos/products_repository.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit({required this.repo}) : super(InitialState()){
    getAllProducts();
  }

final ApiService repo;

  Future<List<Products>> getAllProducts() async {
    var products = <Products>[];
    try {
      emit(LoadingState(state.mainProductState));
      products = await repo.getAllProducts();
      emit(LoadedState(state.mainProductState.copyWith(products: products)));
    } catch (e) {
      emit(ErrorState(state.mainProductState, e.toString()));
    }
    return products;
  }

  void addProducts(Products product, List<Products> products) async{
    try{
      emit(LoadingState(state.mainProductState));
      var addedProduct = await repo.addProduct(product, products);
      emit(LoadedState(state.mainProductState.copyWith(products: addedProduct)));
    }catch(e){
      emit(ErrorState(state.mainProductState, e.toString()));
    }
  }

  void deleteProducts(List<Products> products, int index) async{
    try{
      emit(LoadingState(state.mainProductState));
      var deletedProducts = await repo.deleteProduct(products,index);
      emit(LoadedState(state.mainProductState));
    }catch(e){
      emit(ErrorState(state.mainProductState, e.toString()));
    }
  }

  void updateProducts(Products product, List<Products> products) async{
    try{
      emit(LoadingState(state.mainProductState));
      var newProducts = await repo.updateProduct(product,products);
      emit(LoadedState(state.mainProductState.copyWith(products: newProducts)));
    }catch(e){
      emit(ErrorState(state.mainProductState, e.toString()));
    }
  }
}
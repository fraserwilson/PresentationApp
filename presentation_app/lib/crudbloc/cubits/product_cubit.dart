
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/cubits/product_state.dart';
import 'package:presentation_app/crudbloc/models/products.dart';

import '../repos/products_repository.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit({required this.repo}) : super(LoadingState()){
    getAllProducts();
  }

final ApiService repo;

  Future<List<Products>> getAllProducts() async {
    var products = <Products>[];
    try {
      emit(LoadingState());
      products = await repo.getAllProducts();
      emit(LoadedState(products));
    } catch (e) {
      emit(ErrorState());
    }
    return products;
  }

  Future<List<Products>> addProducts(Products product, List<Products> products) async{
    try{
      emit(LoadingState());
      await repo.addProduct(product, products);
      emit(LoadedState(products));
      return products;
    }catch(e){
      emit(ErrorState());
      return [];
    }
  }

  Future<List<Products>> deleteProducts(List<Products> products, int index) async{
    try{
      emit(LoadingState());
      await repo.deleteProduct(products,index);
      emit(LoadedState(products));
      return products;
    }catch(e){
      emit(ErrorState());
      return [];
    }
  }

  Future<List<Products>> updateProducts(Products product, List<Products> products) async{
    try{
      emit(LoadingState());
      var newProducts = await repo.updateProduct(product,products);
      emit(LoadedState(newProducts));
      return products;
    }catch(e){
      emit(ErrorState());
      return [];
    }
  }
}
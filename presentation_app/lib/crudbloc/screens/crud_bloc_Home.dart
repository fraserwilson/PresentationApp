import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/cubits/auth_cubit.dart';
import 'package:presentation_app/crudbloc/cubits/auth_state.dart';
import 'package:presentation_app/crudbloc/cubits/product_cubit.dart';
import 'package:presentation_app/crudbloc/cubits/product_state.dart';
import 'package:presentation_app/crudbloc/models/products.dart';
import 'package:presentation_app/crudbloc/models/update_products.dart';
import 'package:presentation_app/crudbloc/repos/products_repository.dart';
import 'package:presentation_app/crudbloc/routes.dart';
import 'package:presentation_app/crudbloc/screens/update_item_screen.dart';

class ShoppingListApp extends StatefulWidget {
  const ShoppingListApp({Key? key, required this.repo}) : super(key: key);
  final ApiService repo;

  @override
  State<ShoppingListApp> createState() => _ShoppingListAppState();
}

class _ShoppingListAppState extends State<ShoppingListApp> {
  List<Products> products = <Products>[];
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  getProducts() async {
    await BlocProvider.of<ProductCubit>(context).getAllProducts();
    products =
        BlocProvider.of<ProductCubit>(context).state.mainProductState.products!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "List of Products",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticatedState) {
                Navigator.of(context).pop();
              }
            },
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).signOutOfApp();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(
                  "There was an error retrieving the products. Please try again later"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: state.mainProductState.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Center(
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, updateItem,
                              arguments: UpdateProducts(
                                  state.mainProductState.products![index],
                                  state.mainProductState.products!,
                                  index),);
                        },
                        title: Text(
                            state.mainProductState.products?[index].title ??
                                "Item Could Not Be Loaded"),
                      ),
                    );
                  }),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 5.0,
          child: BlocConsumer<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorState) {
                return const Center(
                  child: Icon(Icons.error),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: titleController,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                                labelText: "Item Title",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: priceController,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                                labelText: "Item Price",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: categoryController,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                                labelText: "Item Category",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: descriptionController,
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                                labelText: "Item Description",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0,
                                                ))),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Products product = Products(
                                                      id: products.length + 1 ??
                                                          99,
                                                      title: titleController
                                                              .text ??
                                                          "",
                                                      price: double.parse(
                                                              priceController
                                                                  .text) ??
                                                          99,
                                                      image: "",
                                                      category:
                                                          categoryController
                                                                  .text ??
                                                              "",
                                                      description:
                                                          descriptionController
                                                                  .text ??
                                                              "");
                                                  BlocProvider.of<ProductCubit>(
                                                          context)
                                                      .addProducts(
                                                          product, products);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Add item',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  // Background color
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: const Text("Add Products",
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black, width: 3),
                        // Background color
                      ),
                    ),
                  ],
                );
              }
            },
            listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "There was an error preforming that action. Please try again")));
              }
            },
          )),
    );
  }
}

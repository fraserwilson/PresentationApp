import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/models/products.dart';
import 'package:presentation_app/crudbloc/models/update_products.dart';
import '../cubits/product_cubit.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem();

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    titleController.text = "";
    priceController.text = "";
    descriptionController.text = "";
    categoryController.text = "";
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var updateInformation =
        ModalRoute.of(context)!.settings.arguments! as UpdateProducts;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Update Page",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleController,
                    onChanged: (data) {
                      if (titleController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          descriptionController.text.isEmpty ||
                          categoryController.text.isEmpty) {
                        isValid = false;
                      } else {
                        isValid = true;
                      }
                      setState(() {});
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText:
                            "Current Value: " + updateInformation.product.title,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: priceController,
                    onChanged: (data) {
                      if (titleController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          descriptionController.text.isEmpty ||
                          categoryController.text.isEmpty) {
                        isValid = false;
                      } else {
                        isValid = true;
                      }
                      setState(() {});
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Current Value: " + updateInformation.product.price.toString(),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: categoryController,
                    onChanged: (data) {
                      if (titleController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          descriptionController.text.isEmpty ||
                          categoryController.text.isEmpty) {
                        isValid = false;
                      } else {
                        isValid = true;
                      }
                      setState(() {});
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Current Value: " + updateInformation.product.category!,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descriptionController,
                    onChanged: (data) {
                      if (titleController.text.isEmpty ||
                          priceController.text.isEmpty ||
                          descriptionController.text.isEmpty ||
                          categoryController.text.isEmpty) {
                        isValid = false;
                      } else {
                        isValid = true;
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        labelText: "Current Value: " + updateInformation.product.description!,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: isValid
                              ? () {
                                  Products product = Products(
                                      id: updateInformation.product.id,
                                      title: titleController.text,
                                      price: double.parse(priceController.text),
                                      image: updateInformation.product.image,
                                      category: categoryController.text,
                                      description: descriptionController.text);
                                  BlocProvider.of<ProductCubit>(context)
                                      .updateProducts(
                                    product,
                                    updateInformation.products,
                                  );
                                  Navigator.of(context).pop(product);
                                }
                              : null,
                          child: Text(
                            'Update item',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black, width: 3),
                            // Background color
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ProductCubit>(context)
                                .deleteProducts(
                              updateInformation.products,
                              updateInformation.productIndex,
                            );
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Delete item',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.black, width: 3),
                            // Background color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

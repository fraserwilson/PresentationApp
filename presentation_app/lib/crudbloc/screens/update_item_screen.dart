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

  @override
  Widget build(BuildContext context) {
    var updateInformation = ModalRoute.of(context)!.settings.arguments! as UpdateProducts;
    return Scaffold(
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
                child: TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: updateInformation.product.title,
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
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: updateInformation.product.price.toString(),
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
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: updateInformation.product.category!,
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
                  decoration: InputDecoration(
                      hintText: updateInformation.product.description!,
                      labelText: "Item Description",
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
                          onPressed: () {
                            Products product = Products(id: updateInformation.product.id, title: titleController.text, price: double.parse(priceController.text), image: updateInformation.product.image, category: categoryController.text, description: descriptionController.text);
                            BlocProvider.of<ProductCubit>(context)
                                .updateProducts(product, updateInformation.products,);
                            Navigator.of(context).pop(product);
                          },
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
                      ),),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            Products product = Products(id: updateInformation.product.id, title: titleController.text, price: double.parse(priceController.text), image: updateInformation.product.image, category: categoryController.text, description: descriptionController.text);
                            BlocProvider.of<ProductCubit>(context)
                                .deleteProducts(updateInformation.products, updateInformation.productIndex,);
                            Navigator.of(context).pop(product);
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
                      ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

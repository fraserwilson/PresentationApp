import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/models/products.dart';
import '../cubits/product_cubit.dart';

class UpdateItem extends StatefulWidget {
   UpdateItem({
    Key? key,
    required this.product, required this.products,
  }) : super(key: key);
  final Products product;
  final List<Products> products;

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
    return Scaffold(
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
                  controller: titleController..text = widget.product.title,
                  textInputAction: TextInputAction.next,
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
                  controller: priceController
                    ..text = widget.product.price.toString(),
                  textInputAction: TextInputAction.next,
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
                  controller: categoryController..text = widget.product.category!,
                  textInputAction: TextInputAction.next,
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
                  controller: descriptionController
                    ..text = widget.product.description!,
                  textInputAction: TextInputAction.next,
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
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Products product = Products(id: widget.product.id, title: titleController.text, price: double.parse(priceController.text), image: widget.product.image, category: categoryController.text, description: descriptionController.text);
                        BlocProvider.of<ProductCubit>(context)
                            .updateProducts(product, widget.products);
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

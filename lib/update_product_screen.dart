import 'dart:convert';

import 'package:crud/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class updateProductScreen extends StatefulWidget {
  const updateProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<updateProductScreen> createState() => _updateProductScreenState();
}

class _updateProductScreenState extends State<updateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  bool _updateProductInProgress=false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.ProductName ?? '';
    _codeTEController.text = widget.product.ProductCode ?? '';
    _unitPriceTEController.text = widget.product.UnitPrice ?? '';
    _quantityTEController.text = widget.product.Quantity ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _imageTEController.text = widget.product.Img ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update product List")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                  const InputDecoration(hintText: "Name", labelText: "Name"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "write your product Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _codeTEController,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                  const InputDecoration(hintText: "Product Code", labelText: "Product Code"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "write your product Code";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Unit Price", labelText: "Unit Price"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "write your product Price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Quantity", labelText: "Quantity"),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return "write your product quantity";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Total Price", labelText: "Total Price"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "write your total product price";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _imageTEController,
                  keyboardType: TextInputType.text,
                  decoration:
                  const InputDecoration(
                      hintText: "Image", labelText: "Image"),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "upload product image";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _updateProductInProgress==false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),

                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()){
                        _updateProduct();
                      }
                    },
                    child: const Text("Update"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Map<String, String> inputData = {
      "ProductName": _nameTEController.text,
      "ProductCode": _codeTEController.text,
      "Img": _imageTEController.text,
      "Qty": _quantityTEController.text,
      "UnitPrice": _unitPriceTEController.text,
      "TotalPrice": _totalPriceTEController.text,
    };

    String updateProductUrl =
        "https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}";
    Uri uri = Uri.parse(updateProductUrl);
    Response response = await post(uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update Product successful")));
      Navigator.pop(context,true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update Product failed! try again")));
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}

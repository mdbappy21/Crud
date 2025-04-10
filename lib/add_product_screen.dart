import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController=TextEditingController();
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  bool _addNewProductionProgress=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
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
                  controller: _productCodeTEController,
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
                  visible: _addNewProductionProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _addProduct();
                        }
                      },
                      child: const Text("Add")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    _addNewProductionProgress=true;
    setState(() {});
    const String addNewProducturl = "https://crud.teamrabbil.com/api/v1/CreateProduct";

    Map<String, dynamic>inputData = {
      "ProductName": _nameTEController.text,
      "ProductCode": _productCodeTEController.text,
      "Img": _imageTEController.text.trim(),
      "Qty": _quantityTEController.text,
      "UnitPrice": _unitPriceTEController.text,
      "TotalPrice": _totalPriceTEController.text
    };

    Uri uri = Uri.parse(addNewProducturl);
    Response response = await post(uri, body: jsonEncode(inputData), headers: {
    'content-type':'application/json'
    });
    print(response.statusCode);
    print(response.body);
    print(response.headers);
    _addNewProductionProgress=false;
    setState(() {});

    if(response.statusCode==200){
      _nameTEController.clear();
      _unitPriceTEController.clear();
      _productCodeTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _imageTEController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("New Product added")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Add New Product failed! try again")));
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

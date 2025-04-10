import 'dart:convert';
import 'package:crud/add_product_screen.dart';
import 'package:crud/product_model.dart';
import 'package:crud/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreen();
}

class _ProductListScreen extends State<ProductListScreen> {
  bool _getProductInProgressList = false;
  List<ProductModel>productList=[];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product list"),
      ),

      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductInProgressList==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProductItem(productList[index]);
            },
            separatorBuilder: (_, __) => const Divider(thickness:2,color: Colors.grey,),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Beveled edges
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void>_getProductList() async{
    _getProductInProgressList=true;
    setState(() {});
    productList.clear();
    const String productListUrl="https://crud.teamrabbil.com/api/v1/ReadProduct";
    Uri uri=Uri.parse(productListUrl);
    Response response = await get(uri);

    if(response.statusCode==200){
      final decodedData=jsonDecode(response.body);
      var jsonProductList=decodedData['data'];


      for(Map<String,dynamic>json in jsonProductList){
        ProductModel productModel = ProductModel.fromJson(json);
       productList.add(productModel);
      }
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Get Product List failed!")));
    }
    _getProductInProgressList=false;
    setState(() {});
  }

  Widget _buildProductItem(ProductModel product) {
    return ListTile(
      leading: Image.network(
        product.Img??'',
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: 60,
            child: Icon(Icons.broken_image),
          );
        },
      ),

        title: Text(product.ProductName??'Unknown'),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text("Unit Price: ${product.UnitPrice}"),
          Text("Quantity: ${product.Quantity}"),
          Text("Total Price: ${product.totalPrice}"),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => updateProductScreen(product: product),
                  ),
                );
                if(result==true){
                  _getProductList();
                }
              },
              icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {
            _showDeleteConfirmationButton(product.id!);
          }, icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationButton(String productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  _deleteProduct(productId);
                  Navigator.pop(context);
                },
                child: const Text("Yes, confirm"))
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(String productId) async {
    _getProductInProgressList = true;
    setState(() {});
    String deleteProductUrl =
        "https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId";
    Uri uri = Uri.parse(deleteProductUrl);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductInProgressList = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Delete Product failed!")));
    }
  }
}
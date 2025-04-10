class ProductModel{
  String? id;
  String? ProductName;
  String? ProductCode;
  String? Img;
  String? UnitPrice;
  String? Quantity;
  String? totalPrice;

  ProductModel.fromJson(Map<String , dynamic>json){
    id=json['_id'];
    ProductName= json['ProductName'];
    ProductCode= json['ProductCode'];
    Img= json['Img'];
    UnitPrice= json['UnitPrice'];
    Quantity= json['Qty'];
    totalPrice= json['TotalPrice'];
  }

}
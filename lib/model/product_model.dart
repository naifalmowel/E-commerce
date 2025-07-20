import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String brand;
  final String image;
  final String dis;
  final String model;
  final String size;
  final String catId;
  int? qty;
  int? currentQty;
  final double price;
   double? offerPrice;
  final bool available;
  final bool active;
  final List<String> images;

  Product({
    required this.id,
    required this.price,
    required this.model,
    required this.size,
    required this.image,
    required this.brand,
    required this.catId,
    required this.dis,
    required this.available,
    required this.images,
    required this.active,
    this.qty,
    this.offerPrice,
    this.currentQty,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc.id,
      price: doc['price'].toDouble(),
      model: doc['model'],
      size: doc['size'],
      image: doc['image'],
      brand: doc['brand'],
      catId: doc['catId'],
      dis: doc['dis'],
      available: doc['available'],
      currentQty: doc['currentQty'],
      images: List<String>.from(doc['images']),
        offerPrice: doc['offerPrice'].toDouble(), active: doc['active']
    );
  }

  factory Product.fromMap(Map<dynamic, dynamic> doc, String id) {
    return Product(
      id: id,
      price: doc['price'].toDouble(),
      model: doc['model'],
      size: doc['size'],
      image: doc['image'],
      brand: doc['brand'],
      catId: doc['catId'].toString(),
      dis: doc['dis'],
      available: doc['available'],
      qty: int.tryParse(doc['qty'].toString())??0,
      images: List<String>.from(doc['images']),
      offerPrice: doc['offerPrice'].toDouble(),
      currentQty: doc['currentQty'],active: doc['active']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id":id.toString(),
      "price":price,
      "model":model,
      "size":size,
      "image":image,
      "brand":brand,
      "catId":catId.toString(),
      "dis":dis,
      "available":available,
      "images":images,
      "qty":qty,
      "offerPrice":offerPrice,
      "currentQty":currentQty,
      "active":active
    };
  }
}
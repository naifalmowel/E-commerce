import 'package:cloud_firestore/cloud_firestore.dart';

class SalesInvoice {
  final String? id;
  final String date;
  final String time;
  final String customerName;
  final String invoiceNumber;
  final String customerId;
  final List<Item> items;
  final double subTotal;
  final double tax;
  final double totalAmount;
  final double paidAmount;
  final String paymentMethod;
  final String status;
  final bool delivered;
  final bool archived;
  final bool read;
  final String addressId;
  final String addressInfo;
  final String shipmentType;
  final double shipmentAmount;
  final Timestamp createdAt;

  // Constructor
  SalesInvoice({
    this.id,
    required this.date,
    required this.time,
    required this.customerName,
    required this.customerId,
    required this.invoiceNumber,
    required this.items,
    required this.subTotal,
    required this.tax,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.delivered,
    required this.addressId,
    required this.addressInfo,
    required this.shipmentType,
    required this.shipmentAmount,
    required this.createdAt,
    required this.archived,
    required this.read,
    required this.paidAmount,
  });

  // From Map
  factory SalesInvoice.fromMap(DocumentSnapshot map) {
    return SalesInvoice(
      id: map.id,
      date: map['date'],
      time: map['time'],
      customerName: map['customerName'],
      customerId: map['customerId'],
      items: (map['items'] as List).map((item) => Item.fromMap(item)).toList(),
      subTotal: map['subTotal'].toDouble(),
      tax: map['tax'].toDouble(),
      totalAmount: map['totalAmount'].toDouble(),
      paymentMethod: map['paymentMethod'],
      status: map['status'],
      delivered: map['delivered'],
      addressId: map['addressId'],
      addressInfo: map['addressInfo'],
      shipmentType: map['shipmentType'],
      shipmentAmount: map['shipmentAmount'].toDouble(),
      invoiceNumber: map['invoiceNumber'],
      createdAt: map['createdAt'],
      archived: map['archived'],
      read: map['read'],
      paidAmount: map['paidAmount'].toDouble(),
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'customerName': customerName,
      'customerId': customerId,
      'items': items.map((item) => item.toMap()).toList(),
      'subTotal': subTotal,
      'tax': tax,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      'delivered': delivered,
      'addressId': addressId,
      'addressInfo': addressInfo,
      'shipmentType': shipmentType,
      'shipmentAmount': shipmentAmount,
      'invoiceNumber': invoiceNumber,
      'createdAt': createdAt,
      'archived': archived,
      'read': read,
      'paidAmount': paidAmount,
    };
  }
}

// Item Model
class Item {
  final String productId;
  final String productName;
  final String image;
  final int quantity;
  final double price;
  final double total;

  // Constructor
  Item({
    required this.productId,
    required this.productName,
    required this.image,
    required this.quantity,
    required this.price,
    required this.total,
  });

  // From Map
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      productId: map['productId'],
      productName: map['productName'],
      quantity: map['quantity'],
      price: map['price'].toDouble(),
      total: map['total'].toDouble(),
      image: map['image'],
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'image': image,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}

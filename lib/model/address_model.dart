import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String id;
  String address;
  String apartment;
  String city;
  String country;
  String postalCode;
  String secondaryPhone;
  DateTime createdAt;

  Address({
    required this.id,
    required this.country,
    required this.createdAt,
    required this.address,
    required this.apartment,
    required this.city,
    required this.postalCode,
    required this.secondaryPhone,
  });

  factory Address.fromDocument(DocumentSnapshot doc) {
    return Address(
      id: doc.id,
      address: doc['address'],
      apartment: doc['apartment'],
      city: doc['city'] ?? '',
      country: doc['country'] ?? '',
      postalCode: doc['postalCode'],
      secondaryPhone: doc['secondaryPhone'],
      createdAt: DateTime.tryParse(doc['createdAt'].toString())??DateTime.now(),
    );
  }

  factory Address.fromMap(Map<dynamic, dynamic> doc, String id) {
    return Address(
      id: id,
      address: doc['address'],
      apartment: doc['apartment'],
      city: doc['city'],
      country: doc['country'],
      postalCode: doc['postalCode'],
      secondaryPhone: doc['secondaryPhone'],
      createdAt: DateTime.tryParse(doc['createdAt'].toString())??DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "address": address,
      "apartment": apartment,
      "city": city,
      "country": country,
      "postalCode": postalCode,
      "secondaryPhone": secondaryPhone,
      "createdAt": createdAt,
    };
  }
}

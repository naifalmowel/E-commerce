
import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory Category.fromDocument(DocumentSnapshot doc) {
    return Category(
      id: doc.id,
      name: doc['name'],
      image: doc['image'],
      description: doc['description'],
    );
  }
}



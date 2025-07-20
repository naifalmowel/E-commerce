import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselModel {
  String id;
  String title;
  String connectUrl;
  List<String> images;
  bool showButton;

  CarouselModel({
    required this.id,
    required this.images,
    required this.title,
    required this.showButton,
    required this.connectUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'images': images,
      'showButton': showButton,
      'connectUrl': connectUrl,
    };
  }

  factory CarouselModel.fromMap(DocumentSnapshot doc) {
    return CarouselModel(
      id: doc.id,
      title: doc['title'],
      images: List<String>.from(doc['images']),
      showButton: doc['showButton'],
      connectUrl: doc['connectUrl'],
    );
  }
}

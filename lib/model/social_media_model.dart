import 'package:cloud_firestore/cloud_firestore.dart';

class SocialModel {
  String id;
  String facebookUrl;
  bool facebook;
  String instagramUrl;
  bool instagram;
  String whatsUrl;
  bool whats;
  String tiktokUrl;
  String logo;
  bool tiktok;
  bool withoutLogo;

  SocialModel({
    required this.id,
    required this.tiktok,
    required this.instagram,
    required this.facebook,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.tiktokUrl,
    required this.whats,
    required this.whatsUrl,
    required this.logo,
    required this.withoutLogo,

  });

  factory SocialModel.fromDocument(DocumentSnapshot doc) {
    return SocialModel(
      id : doc.id,
        tiktok : doc['tiktok'],
        instagram : doc['instagram'],
        facebook : doc['facebook'],
        facebookUrl : doc['facebookUrl'],
        instagramUrl : doc['instagramUrl'],
        tiktokUrl : doc['tiktokUrl'],
        whats : doc['whats'],
        whatsUrl : doc['whatsUrl'],
      logo : doc['logo'],
      withoutLogo : doc['withoutLogo'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "tiktok" : tiktok,
      "instagram" : instagram,
      "facebook" : facebook,
      "facebookUrl" : facebookUrl,
      "instagramUrl" : instagramUrl,
      "tiktokUrl" : tiktokUrl,
      "whats" : whats,
      "whatsUrl" : whatsUrl,
      "logo" : logo,
      "withoutLogo" : withoutLogo,
    };
  }
}

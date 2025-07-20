import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/util/social_media.dart';

class PrivacyPage extends StatelessWidget {
   const PrivacyPage({super.key , required this.title, required this.body});
final String title ;
final String body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.grey.withOpacity(0.5),
            Colors.grey.withOpacity(0.2)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        onPressed: () {
                          Get.back();
                        },
                      )),
                  Center(child: Text(title , style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 25),),),
                  const Divider(thickness: 1,color: Colors.black54,),
                  Center(child: Text(body ,  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 15 , fontWeight: FontWeight.w500),),),
                  const Divider(thickness: 1,color: Colors.black54,),
                  const SocialMedia(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

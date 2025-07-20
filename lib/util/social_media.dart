import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}
final controller1 = Get.find<AdminController>();
class _SocialMediaState extends State<SocialMedia> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 125,
        child: Obx(()=>Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(controller1.socialMedia.first.facebook)  Expanded(
              child: GestureDetector(
                onTap: () {
                  launchURL(
                      controller1.socialMedia.first.facebookUrl);
                },
                child: const Icon(
                  FontAwesomeIcons.facebook,
                  size: 15,
                ),
              ),
            ),
            if(controller1.socialMedia.first.instagram)  Expanded(
              child: GestureDetector(
                onTap: () {
                  launchURL(
                      controller1.socialMedia.first.instagramUrl);
                },
                child: const Icon(
                  FontAwesomeIcons.instagram,
                  size: 15,
                ),
              ),
            ),
            if(controller1.socialMedia.first.whats)  Expanded(
              child: GestureDetector(
                onTap: () {
                  launchURL(
                      controller1.socialMedia.first.whatsUrl);
                },
                child: const Icon(
                  FontAwesomeIcons.whatsapp,
                  size: 15,
                ),
              ),
            ),
            if(controller1.socialMedia.first.tiktok)  Expanded(
              child: GestureDetector(
                onTap: () {
                  launchURL(
                      controller1.socialMedia.first.tiktokUrl);
                },
                child: const Icon(
                  FontAwesomeIcons.tiktok,
                  size: 15,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void launchURL(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Can not Open This URL : $url')));
    }
  }
}

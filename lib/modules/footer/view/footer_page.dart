import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/footer/view/footer_button_widget/privacy_page.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/social_media.dart';

import '../../../util/colors.dart';
import '../../../util/text_util.dart';
import '../../admin/admin_controller.dart';
import 'footer_button_widget/contact_us_page.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 2,
        ),
         Padding(
          padding: EdgeInsets.all(8.0),
          child:Obx(()=>
          Get.find<AdminController>().isLoading.value || Get.find<AdminController>().isLoadingC.value ?Center(child: CircularProgressIndicator(color: secondaryColor,),):
          Get.find<AdminController>().withoutLogo.value
              ? TextUtil(
            text: Get.find<AdminController>()
                .listCarousel.isNotEmpty?Get.find<AdminController>()
                .listCarousel
                .last
                .title : "LOGO",
            size: 25,
          )
              : CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            child: ClipOval(
              child: Get.find<AdminController>()
                  .logoImages
                  .value
                  .isNotEmpty
                  ? Image.network(
                Get.find<AdminController>()
                    .logoImages
                    .value,
                width: 70,
                // تأكد أن الحجم يتناسب مع `radius`
                height: 70,
                fit: BoxFit.cover,
                // اجعل الصورة تغطي الدائرة بشكل جيد
                errorBuilder:
                    (context, error, stackTrace) =>
                    Image.asset(
                      'assets/image/logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
              )
                  : Image.asset(
                'assets/image/logo.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),),
          ),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.to(()=>const ContactUs());
                  },
                  child:  Text(
                    'Contact Us',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.to(()=> PrivacyPage(title: 'Privacy Policy', body: Constant.privacy));
                  },
                  child:  Text(
                    'Privacy Policy',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.to(()=> PrivacyPage(title: 'Terms and Conditions', body: Constant.termsConditions));
                  },
                  child:  Text(
                    'Terms and Conditions',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {Get.to(()=> PrivacyPage(title: 'Return and Refund Policy', body: Constant.returnRefund));},
                  child:  Text(
                    'Return and Refund Policy',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
            ),
          ],
        ),
        const SocialMedia(),
        const Divider(
          thickness: 2,
        ),
         Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Welcome To Sumer for Discount',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15),
                ),
              ),
            )),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(FontAwesomeIcons.ccVisa),
                  Icon(FontAwesomeIcons.paypal),
                  Icon(FontAwesomeIcons.ccMastercard),
                  Icon(FontAwesomeIcons.moneyCheck),
                ],
              ),
            )),
          ],
        )
      ],
    );
  }
}

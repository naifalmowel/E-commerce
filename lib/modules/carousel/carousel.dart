import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  List<String> carousels = [
    'assets/image/1.jpg',
    'assets/image/2.jpg',
    'assets/image/3.jpg',
    'assets/image/4.jpg',
  ];
  final controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Get.width/22),
      child: Obx(() => controller.isLoadingC.value
          ? Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            )
          : CarouselSlider.builder(
              itemCount: controller.listCarousel.isNotEmpty
                  ? controller.listCarousel.last.images.isNotEmpty
                      ? controller.listCarousel.last.images.length
                      : carousels.length
                  : carousels.length,
              itemBuilder: (context, index, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          children: [
                            controller.listCarousel.isNotEmpty
                                ? controller.listCarousel.last.images.isNotEmpty
                                    ?
                                Image.network(controller
                                    .listCarousel.last.images[index],width: double.infinity,
                                  height: double.infinity, fit: BoxFit.fill, errorBuilder: (context, url, error) => Image.asset(
                                      'assets/image/noImage.jpg'),

                                )
                                    : Image.asset(
                                        carousels[index],
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: double.infinity,
                                      )
                                : Image.asset(
                                    carousels[index],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      controller.listCarousel.isNotEmpty
                                          ? controller.listCarousel.first.title
                                          : 'NAIF For Discount',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  controller.listCarousel.isNotEmpty?
                                  controller.listCarousel.first.showButton?   ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  secondaryColor)),
                                      onPressed: controller.listCarousel.first.connectUrl.isNotEmpty ? () {
                                        launchURL(
                                            controller.listCarousel.first.connectUrl);
                                        setState(() {});
                                      }:null,
                                      child: const Text(
                                        'Connect Us',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )):SizedBox() : SizedBox()
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
              disableGesture: true,
              options: CarouselOptions(
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                 pageSnapping: true,
                  aspectRatio: MediaQuery.of(context).size.width > 1200
                      ? 2.5
                      : MediaQuery.of(context).size.width <= 800
                          ? 2
                          : 3.5,
                  autoPlay: controller.listCarousel.isNotEmpty && controller.listCarousel.last.images.length ==1? false :true,
                  scrollPhysics: controller.listCarousel.isNotEmpty && controller.listCarousel.last.images.length ==1?NeverScrollableScrollPhysics():null,
                  padEnds: true,
                  viewportFraction: 1))),
    );
  }

  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Can not Open This URL : $url')));
    }
  }
}

import 'package:get/get.dart';
import "package:emailjs/emailjs.dart" as emailjs;
class FooterController extends GetxController{
  RxBool loading = false.obs;


  Future<bool> sendEmail({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String body,
  }) async {
    loading(true);
    Map<String, dynamic> templateParams = {
      'name': name,
      'from': email,
      'phone': phone,
      'subject': subject,
      'body': body,
      'to':'Naif Almowel'
    };

    try {
      await emailjs.send(
        'service_ph261za',
        'template_e09kno6',
        templateParams,
        const emailjs.Options(
          publicKey: 'Lw4Y7cTCiYUtPNWxv', // استبدل بـ Public Key الخاص بك
          privateKey: 'M_IOMHQq5SBXI_N1WNirL', // استبدل بـ Private Key الخاص بك
        ),
      );
      loading(false);
     return true;

    } catch (error) {
      loading(false);
      return false;
    }
  }
}
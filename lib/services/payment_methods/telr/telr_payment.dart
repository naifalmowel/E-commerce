
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:sumer/services/payment_methods/telr/telr_pay_page.dart';
import 'package:sumer/util/constant.dart';
import '../../../model/invoice_model.dart';
import '../../../modules/cart/controller/cart_controller.dart';
import '../../../modules/checkout/controller/checkout_controller.dart';
import '../../../modules/checkout/view/success_add_bill.dart';

class TelrPayment {
  static Future<void> startPayment(BuildContext context, double amount) async {
    try {
      final response = await _createPayment(amount);
      final responseData = response.data;
      if (!context.mounted) {
        return;
      }
      if (responseData["order"] != null) {
        String paymentUrl = responseData["order"]["url"];

        String? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelrPaymentPage(paymentUrl: paymentUrl),
          ),
        );
        print(result);
        if (result != null) {
          if (result.contains('Successful')) {
            if (!context.mounted) {
              return;
            }
            Constant.showSnakeBarSuccess(context, '✅ Payment Successful');
            SalesInvoice sales =
                await g.Get.find<CheckoutController>().initBill(isCard: true);
            bool result = await g.Get.find<CheckoutController>()
                .addInvoiceWithMaterialMovements(sales.toMap());
            if (result) {
              if (!context.mounted) {
                return;
              }
              g.Get.to(() => CheckoutConfirmationPage(
                    invoiceData: g.Get.find<CheckoutController>().salesPrint,
                  ));
              Constant.showSnakeBarSuccess(
                  context, 'Your request has been successfully accepted ...');
              await g.Get.find<CartController>().clearCart();
              g.Get.find<CheckoutController>().submitLoading(false);
            } else {
              g.Get.find<CheckoutController>().submitLoading(false);
              if (!context.mounted) {
                return;
              }
              Constant.showSnakeBarError(
                  context, 'Something went wrong please try again ...');
            }
          }
          else if (result.contains('Canceled')) {
            if (!context.mounted) {
              return;
            }
            Constant.showSnakeBarError(context, '❌ Payment Canceled');
          }
          else if (result.contains('Declined')) {
            Constant.showSnakeBarError(context, '⚠️ Payment Declined');
          }else if (result.contains('Opened')){
            print('object');
          }
        } else {
          if (!context.mounted) {
            return;
          }
          Constant.showSnakeBarError(context, 'finish');
        }
      } else {
        print(responseData['error']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشلت عملية الدفع: ${responseData['error']}")),
        );
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      print("Error  $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: $e")),
      );
    }
  }

  static Future<Response> _createPayment(double amount) async {
    Dio dio = Dio();
    final response = await dio.post(
      "https://secure.telr.com/gateway/order.json",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
        },
      ),
      data: {
        "method": "create",
        "store": 31489,
        "authkey": "s9vjz@CnW27-L4jh",
        "framed": 0,
        "order": {
          "cartid": "ORDER_${DateTime.now().millisecondsSinceEpoch}",
          "test": "1",
          "amount": "$amount",
          "currency": "AED",
          "description": "My purchase"
        },
        "return": {
          "authorised": "https://www.mysite.com/authorised",
          "success": "https://www.mysite.com/success",
          "declined": "https://www.mysite.com/declined",
          "cancelled": "https://www.mysite.com/cancelled"
        }
      },
    );
    return response;
  }
}

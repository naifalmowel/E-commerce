import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw; // مكتبة لإنشاء PDF
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../product/controller/product_controller.dart';


class CheckoutConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> invoiceData;

  const CheckoutConfirmationPage({super.key, required this.invoiceData});

  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();
    var  ttf;
    if (kIsWeb) {
       ttf = await PdfGoogleFonts.iBMPlexSansArabicBold();
    }else{
      final ByteData fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
       ttf = pw.Font.ttf(fontData);
    }


    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Invoice Confirmation', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Invoice Number: ${invoiceData["invoiceNumber"]}'),
            pw.Text('Date: ${invoiceData["date"]}'),
            pw.Text('Customer Name: ${invoiceData["customerName"]}'),
            pw.Text('Payment Method: ${invoiceData["paymentMethod"]}'),
            pw.Text('Shipment Type: ${invoiceData["shipmentType"]}'),
            pw.SizedBox(height: 8),
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
                children: [
                  pw.Text('Shipment Info', style: pw.TextStyle( fontWeight: pw.FontWeight.bold)),
                  pw.Divider(),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(invoiceData["addressInfo"] , textDirection :pw.TextDirection.rtl ,style: pw.TextStyle(font: ttf)),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Items:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.ListView.builder(
              itemCount: invoiceData["items"].length,
              itemBuilder: (context, index) {
                final item = invoiceData["items"][index];
                return pw.Row(
                   mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                pw.Text('${index + 1}. ${item["productName"]} - Qty: ${item["quantity"]} - Price: ${item["price"]} - Total: ${item["total"]}')

                ]
                );},
            ),
            pw.Divider(),
            pw.SizedBox(height: 20),
            pw.Text('Subtotal: ${invoiceData["subTotal"]} AED'),
            pw.Text('Shipment Amount: ${invoiceData["shipmentAmount"]} AED'),
            pw.Text('Tax: ${invoiceData["tax"]} AED'),
            pw.Text('Total Amount: ${invoiceData["totalAmount"]} AED'),
          ],
        ),
      ),
    );
    // تحويل PDF إلى Uint8List
    final Uint8List pdfBytes = await pdf.save();

    // 3. التحقق من المنصة
    if (kIsWeb) {
      // إذا كان على الويب
      final blob = html.Blob([pdfBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'invoice${invoiceData["invoiceNumber"]}.pdf'
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // إذا كان على أندرويد أو iOS
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/invoice${invoiceData["invoiceNumber"]}.pdf";
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
       await Get.find<ProductController>().fetchProducts('0');
        Get.offAllNamed('/');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Invoice Confirmation'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: ()async{
              await generatePDF(context);
            }, icon: Icon(Icons.download),
              tooltip: 'Download PDF',
            )
          ],
          leading: IconButton(onPressed: (){
            Get.find<ProductController>().fetchProducts('0');
            Get.offAllNamed('/');
          }, icon: Icon(Icons.close)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Icon(Icons.check_circle_sharp , size: 200, color: Colors.green,)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Invoice Number: ${invoiceData["invoiceNumber"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text('Date: ${invoiceData["date"]} ${invoiceData["time"]}' , style: TextStyle(color: Colors.black),),
                Text('Customer Name: ${invoiceData["customerName"]}', style: TextStyle(color: Colors.black)),
                Text('Payment Method: ${invoiceData["paymentMethod"]}', style: TextStyle(color: Colors.black)),
                Text('Shipment Type: ${invoiceData["shipmentType"]}', style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Text('Shipment Info', style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold)),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(invoiceData["addressInfo"], style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Items:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Colors.black)),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: invoiceData["items"].length,
                  itemBuilder: (context, index) {
                    final item = invoiceData["items"][index];
                    return ListTile(
                      leading:   Badge(
                        label: Text(
                          item['quantity']
                              .toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        backgroundColor: Colors.blueAccent,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey),
                                borderRadius:
                                const BorderRadius.all(
                                    Radius.circular(10))),
                            width: 100,
                            height: 100,
                            child:
                            Image.network(item['image'],
                              fit: BoxFit.contain, errorBuilder: (context, url, error) =>
                                  Image.asset(
                                      'assets/image/noImage.jpg'),

                            )),
                      ),
                      title: Text(item["productName"] , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold , color: Colors.black)),
                      subtitle: Text('Qty: ${item["quantity"]}, Price: ${item["price"]} AED , Total: ${item["total"]} AED' , style: TextStyle(fontSize: 13, color: Colors.black)),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text('Subtotal: ${invoiceData["subTotal"]} AED' , style: TextStyle( color: Colors.black)),
                Text('Shipment Amount: ${invoiceData["shipmentAmount"]} AED', style: TextStyle(color: Colors.black)),
                Text('Tax: ${invoiceData["tax"]} AED' , style: TextStyle( color: Colors.black)),
                Text('Total Amount: ${invoiceData["totalAmount"]} AED', style: const TextStyle(fontWeight: FontWeight.bold ,  color: Colors.black)),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

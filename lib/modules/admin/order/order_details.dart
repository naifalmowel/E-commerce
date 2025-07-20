import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:sumer/model/invoice_model.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/constant.dart';
import 'package:sumer/util/text_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.invoice, required this.isUser});

  final SalesInvoice invoice;
  final bool isUser;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

var adminController = Get.find<AdminController>();

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    adminController.invoiceStatus.value = widget.invoice.status;
    adminController.paidAmount.value = widget.invoice.paidAmount;
    adminController.delivered.value = widget.invoice.delivered;
    adminController.read.value = widget.invoice.read;
    super.initState();
  }
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
            pw.Text('Invoice Number: ${widget.invoice.invoiceNumber}'),
            pw.Text('Date: ${widget.invoice.date}'),
            pw.Text('Customer Name: ${widget.invoice.customerName}'),
            pw.Text('Payment Method: ${widget.invoice.paymentMethod}'),
            pw.Text('Shipment Type: ${widget.invoice.shipmentType}'),
            pw.SizedBox(height: 8),
            pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Column(
                children: [
                  pw.Text('Shipment Info', style: pw.TextStyle( fontWeight: pw.FontWeight.bold)),
                  pw.Divider(),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(widget.invoice.addressInfo , textDirection :pw.TextDirection.rtl ,style: pw.TextStyle(font: ttf)),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Items:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.ListView.builder(
              itemCount: widget.invoice.items.length,
              itemBuilder: (context, index) {
                final item = widget.invoice.items[index];
                return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text('${index + 1}. ${item.productName} - Qty: ${item.quantity} - Price: ${item.price} - Total: ${item.total}')

                    ]
                );},
            ),
            pw.Divider(),
            pw.SizedBox(height: 20),
            pw.Text('Subtotal: ${widget.invoice.subTotal} AED'),
            pw.Text('Shipment Amount: ${widget.invoice.shipmentAmount} AED'),
            pw.Text('Tax: ${widget.invoice.tax} AED'),
            pw.Text('Total Amount: ${widget.invoice.totalAmount} AED'),
          ],
        ),
      ),
    );
    final Uint8List pdfBytes = await pdf.save();

    if (kIsWeb) {
      final blob = html.Blob([pdfBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
       html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'invoice${widget.invoice.invoiceNumber}.pdf'
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // إذا كان على أندرويد أو iOS
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/invoice${widget.invoice.invoiceNumber}.pdf";
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(filePath);
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.shade300),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BackButton(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    headerOrder(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              itemsOrder(),
                              SizedBox(
                                height: 20,
                              ),
                              payOrder(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        width > 700
                            ? SizedBox(
                                width: 25,
                              )
                            : SizedBox(),
                        width > 700
                            ? Expanded(
                                child: customerInfo(),
                              )
                            : SizedBox()
                      ],
                    ),
                    width > 700 ? SizedBox() : customerInfo(),
                  ],
                )),
          ),
        ),
      ),
    ));
  }

  Widget headerOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextUtil(
              text: widget.invoice.invoiceNumber,
              size: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: adminController.invoiceStatus.value.contains('Due')
                      ? Colors.grey
                      : Colors.green,
                ),
                SizedBox(
                  width: 5,
                ),
                TextUtil(
                  text: adminController.invoiceStatus.value,
                  color: adminController.invoiceStatus.value.contains('Due')
                      ? Colors.grey
                      : Colors.green,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: !adminController.delivered.value
                      ? errorColor
                      : Colors.green,
                ),
                SizedBox(
                  width: 5,
                ),
                TextUtil(
                  text: adminController.delivered.value
                      ? 'Delivered'
                      : 'Not Delivered',
                  color: !adminController.delivered.value
                      ? errorColor
                      : Colors.green,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            if(!widget.isUser)Icon(
              adminController.read.value
                  ? Icons.mark_email_read_outlined
                  : Icons.mark_email_unread_rounded,
              color: adminController.read.value ? Colors.green : Colors.grey,
              size: 20,
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('yyyy/MM/dd hh:ss aaa')
                  .format(widget.invoice.createdAt.toDate()),
              style: TextStyle(color: Colors.black54),
            ),
             PopupMenuButton(
              color: Colors.white,
              tooltip: "More Option",
              iconColor: Colors.black,
              itemBuilder: (BuildContext context) {
                return !widget.isUser ?
                <PopupMenuItem<Widget>>[
                    adminController.read.value
                      ? PopupMenuItem<Widget>(
                          onTap: () async {
                            await Get.find<AdminController>().readInvoice(
                              invoiceId: widget.invoice.id!,
                              read: false,
                            );
                            adminController.read.value = false;
                            Get.find<AdminController>().getAllInvoice();
                            Get.find<AdminController>().getAllInvoiceForUser(userId: widget.invoice.customerId);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.mark_email_unread_rounded,
                                  color: secondaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("UnRead",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        )
                      : PopupMenuItem<Widget>(
                          onTap: () async {
                            await Get.find<AdminController>().readInvoice(
                              invoiceId: widget.invoice.id!,
                              read: true,
                            );
                            adminController.read.value = true;
                            Get.find<AdminController>().getAllInvoice();
                            Get.find<AdminController>().getAllInvoiceForUser(userId: widget.invoice.customerId);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.mark_email_read_outlined,
                                  color: secondaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("Read",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                  (PopupMenuItem<Widget>(
                    onTap: () async {
                      await generatePDF(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.sim_card_download_outlined,
                            color: secondaryColor),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Download PDF",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  )),
                ] : <PopupMenuItem<Widget>>[
                 (PopupMenuItem<Widget>(
                    onTap: () async {
                      await generatePDF(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.sim_card_download_outlined,
                            color: secondaryColor),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Download PDF",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  )),
                ];
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_drop_down),
                  TextUtil(text: 'More Option'),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget itemsOrder() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextUtil(
              text:
                  'Items (${widget.invoice.items.map((e) => e.quantity).reduce((a, b) => a + b)})',
              size: 20,
            ),
            Divider(),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.invoice.items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Badge(
                          label: Text(
                            widget.invoice.items[index].quantity.toString(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          backgroundColor: Colors.blueAccent,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              width: 75,
                              height: 75,
                              child: Image.network(
                                widget.invoice.items[index].image,
                                fit: BoxFit.fill,
                                errorBuilder: (context, url, error) =>
                                    Image.asset('assets/image/noImage.jpg'),
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.invoice.items[index].productName,
                                  style: TextStyle(color: Colors.black54)),
                              TextUtil(
                                  text:
                                      'Total : ${widget.invoice.items[index].total}')
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget payOrder() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: adminController.invoiceStatus.value.contains('Due')
                      ? Colors.grey
                      : Colors.green,
                ),
                SizedBox(
                  width: 5,
                ),
                TextUtil(
                  text: adminController.invoiceStatus.value,
                  color: adminController.invoiceStatus.value.contains('Due')
                      ? Colors.grey
                      : Colors.green,
                  size: 20,
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtil(
                  text: 'Subtotal',
                  weight: true,
                ),
                TextUtil(
                  text: '${widget.invoice.subTotal.toStringAsFixed(2)} AED',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtil(
                  text: 'Shipping (${widget.invoice.shipmentType})',
                  weight: true,
                ),
                TextUtil(
                  text:
                      '${widget.invoice.shipmentAmount.toStringAsFixed(2)} AED',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtil(
                  text: 'Total',
                  weight: true,
                ),
                TextUtil(
                  text: '${widget.invoice.totalAmount.toStringAsFixed(2)} AED',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextUtil(
              text:
                  'Paid Amount : ${adminController.paidAmount.value.toStringAsFixed(2)} AED',
            ),
            TextUtil(
              text: widget.invoice.paymentMethod,
            ),
            Divider(),
            if(!widget.isUser)  adminController.isLoadingPay.value
                ? Center(child: CircularProgressIndicator())
                : adminController.paidAmount.value == 0
                    ? Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Constant.confirmDialog(context, 'Pay', () async {
                              Get.back();
                              await Get.find<AdminController>().payInvoice(
                                  invoiceId: widget.invoice.id!,
                                  status: 'Paid',
                                  paidAmount: widget.invoice.totalAmount);
                              adminController.paidAmount.value =
                                  widget.invoice.totalAmount;
                              adminController.invoiceStatus.value = 'Paid';
                              Get.find<AdminController>().getAllInvoice();
                              Get.find<AdminController>().getAllInvoiceForUser(userId: widget.invoice.customerId);
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateColor.resolveWith(
                            (states) => secondaryColor,
                          )),
                          label: Text(
                            'Pay',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(Icons.payment, color: Colors.white),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            Constant.confirmDialog(
                                context, 'Cansel This Payment', () async {
                              Get.back();
                              await Get.find<AdminController>().payInvoice(
                                  invoiceId: widget.invoice.id!,
                                  status: 'Due',
                                  paidAmount: 0.0);
                              adminController.paidAmount.value = 0.0;
                              adminController.invoiceStatus.value = 'Due';
                              Get.find<AdminController>().getAllInvoice();
                              Get.find<AdminController>().getAllInvoiceForUser(userId: widget.invoice.customerId);
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateColor.resolveWith(
                            (states) => errorColor,
                          )),
                          label: Text(
                            'Cansel Pay',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(Icons.cancel_presentation,
                              color: Colors.white),
                        ),
                      )
          ],
        ),
      ),
    );
  }

  Widget customerInfo() {
    var user = Get.find<AdminController>()
        .users
        .firstWhereOrNull((e) => e.id == widget.invoice.customerId);
    String username = '';
    String email = '';
    String phone = '';
    if (user != null) {
      username = user.username;
      email = user.email;
      phone = user.phoneNo;
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextUtil(
              text: 'Customer',
              size: 20,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: secondaryColor.withAlpha(178),
                  radius: 20,
                  child: Text(
                    username[0].toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextUtil(text: username)
              ],
            ),
            Divider(),
            TextUtil(
              text: 'Contact information',
              size: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: email,
                      query:
                          'subject=Hello&body=This is a test email', // يمكن تعديل العنوان والمحتوى
                    );
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    } else {
                      print('Could not launch $emailUri');
                    }
                  },
                  label: TextUtil(
                    text: email,
                    color: secondaryColor,
                  ),
                  icon: Icon(
                    Icons.alternate_email,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } else {
                      print('Could not launch $phoneUri');
                    }
                  },
                  label: TextUtil(
                    text: phone,
                    color: secondaryColor,
                  ),
                  icon: Icon(
                    Icons.phone_android,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            TextUtil(
              text: 'Shipping Address',
              size: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUtil(text: widget.invoice.addressInfo, weight: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: !adminController.delivered.value
                          ? errorColor
                          : Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextUtil(
                      text: adminController.delivered.value
                          ? 'Delivered'
                          : 'Not Delivered',
                      color: !adminController.delivered.value
                          ? errorColor
                          : Colors.green,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if(!widget.isUser)  adminController.isLoadingD.value
                ? Center(child: CircularProgressIndicator())
                : adminController.delivered.value
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          Constant.confirmDialog(context, 'Cancel Delivery',
                              () async {
                            Get.back();
                            await adminController.deliveredShipment(
                                invoiceId: widget.invoice.id!,
                                delivered: false);
                            adminController.delivered.value = false;
                            Get.find<AdminController>().getAllInvoice();
                            Get.find<AdminController>().getAllInvoiceForUser(userId: widget.invoice.customerId);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith(
                                (s) => errorColor)),
                        label: TextUtil(
                          text: 'Cancel Delivery',
                          color: Colors.white,
                        ),
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () async {
                          Constant.confirmDialog(context, 'Delivered',
                              () async {
                            Get.back();

                            await adminController.deliveredShipment(
                                invoiceId: widget.invoice.id!, delivered: true);
                            adminController.delivered.value = true;
                            Get.find<AdminController>().getAllInvoice();
                            Get.find<AdminController>().getAllInvoiceForUser(userId: widget.invoice.customerId);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStateColor.resolveWith(
                                (s) => secondaryColor)),
                        label: TextUtil(
                          text: 'Delivered',
                          color: Colors.white,
                        ),
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

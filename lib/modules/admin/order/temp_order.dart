import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/model/invoice_model.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import '../../../util/colors.dart';
import '../../../util/text_util.dart';
import 'order_details.dart';

class TempOrder extends StatefulWidget {
  const TempOrder({super.key, required this.invoice});

  final SalesInvoice invoice;

  @override
  State<TempOrder> createState() => _TempOrderState();
}
var adminController = Get.find<AdminController>();
class _TempOrderState extends State<TempOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:widget.invoice.read?null: Colors.black.withAlpha(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: InkWell(
          onTap: () {
            Get.to(()=>OrderDetails(invoice: widget.invoice, isUser: false,));
          },
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Checkbox(
                  activeColor: secondaryColor,
                    value: adminController.selectOrder.contains(widget.invoice.id), onChanged: (v){
                  setState(() {
                    if(adminController.selectOrder.contains(widget.invoice.id)){
                      adminController.selectOrder.remove(widget.invoice.id);
                    }else{
                      adminController.selectOrder.add(widget.invoice.id??'');
                    }
                  });
                }),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  widget.invoice.invoiceNumber,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    var user = Get.find<AdminController>().users.firstWhereOrNull(
                        (e) => e.id == widget.invoice.customerId);

                    if (user == null) {
                      return;
                    }
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        details.globalPosition.dx, // موقع الضغط الأفقي
                        details.globalPosition.dy, // موقع الضغط العمودي
                        details.globalPosition.dx + 200, // العرض المتوقع
                        details.globalPosition.dy + 200, // الارتفاع المتوقع
                      ),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      items: [
                        PopupMenuItem(
                          enabled: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey)),
                              SelectableText(user.email,
                                  style: TextStyle(color: Colors.blue)),
                              SelectableText(user.phoneNo,
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        widget.invoice.customerName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    "${widget.invoice.totalAmount} AED",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: widget.invoice.status.contains('Due')
                            ? Colors.grey
                            : Colors.green,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.invoice.status,
                        style: TextStyle(
                          color: widget.invoice.status.contains('Due')
                              ? Colors.grey
                              : Colors.green,
                        ),
                      ),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    widget.invoice.shipmentType.contains('Slow')
                        ? 'SLOW'
                        : widget.invoice.shipmentType.contains('Free')
                            ? 'FREE'
                            : 'Fast',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      var user = Get.find<AdminController>()
                          .users
                          .firstWhereOrNull(
                              (e) => e.id == widget.invoice.customerId);

                      if (user == null) {
                        return;
                      }
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          details.globalPosition.dx, // موقع الضغط الأفقي
                          details.globalPosition.dy, // موقع الضغط العمودي
                          details.globalPosition.dx + 200, // العرض المتوقع
                          details.globalPosition.dy + 200, // الارتفاع المتوقع
                        ),
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        items: widget.invoice.items
                            .map(
                              (e) => PopupMenuItem(
                                enabled: false,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Badge(
                                        label: Text(
                                          e.quantity.toString(),
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
                                            width: 75,
                                            height: 75,
                                            child: Image.network(
                                              e.image,
                                              fit: BoxFit.fill,
                                              errorBuilder: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      'assets/image/noImage.jpg'),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(e.productName,
                                            style:
                                                TextStyle(color: Colors.black54)),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "${widget.invoice.items.length.toString()} Items",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: !widget.invoice.delivered
                            ? errorColor
                            : Colors.green,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextUtil(
                          text: widget.invoice.delivered? 'Delivered': 'Not Delivered',
                          color: !widget.invoice.delivered
                              ? errorColor
                              : Colors.green,
                          size: 12,
                        ),
                      ),
                    ],
                  ),),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: PopupMenuButton(
                    color: Colors.white,
                    tooltip: "Action",
                    icon: const Icon(Icons.more_vert_rounded),
                    iconColor: Colors.black,
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem<Widget>>[
                        PopupMenuItem<Widget>(
                          onTap: () async{
                            await Get.find<AdminController>().readInvoice(
                              invoiceId: widget.invoice.id!,
                              read: !widget.invoice.read,
                            );
                            Get.find<AdminController>().getAllInvoice();
                          },
                          child: Row(
                            children: [
                              Icon(widget.invoice.read ?Icons.mark_email_unread_rounded : Icons.mark_email_read_outlined, color: secondaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.invoice.read ? "UnRead" :"Read", style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        PopupMenuItem<Widget>(
                          onTap: () {
                            Get.to(()=>OrderDetails(invoice: widget.invoice, isUser: false,));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.remove_red_eye, color: secondaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("View", style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        PopupMenuItem<Widget>(
                          onTap: () async {
                            await Get.find<AdminController>().archivedInvoice(
                              invoiceId: widget.invoice.id!,
                              archived: !widget.invoice.archived,
                            );
                            Get.find<AdminController>().getAllInvoice();
                          },
                          child: Row(
                            children: [
                              Icon(widget.invoice.archived?Icons.unarchive:Icons.archive, color: secondaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.invoice.archived?"UnArchive":"Archived",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ];
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

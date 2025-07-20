import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/model/user_model.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/admin/users/user_info.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';

import '../../../util/colors.dart';

class TempUser extends StatefulWidget {
  const TempUser({super.key, required this.user});

  final UserModel user;

  @override
  State<TempUser> createState() => _TempUserState();
}

class _TempUserState extends State<TempUser> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.find<CheckoutController>()
            .getAllAddressForUser(userId: widget.user.id);
        Get.find<AdminController>().getAllInvoiceForUser(userId: widget.user.id);
        Get.to(() => UsersInfo(
          user: widget.user,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  widget.user.username,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  widget.user.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                )),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  widget.user.phoneNo,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                )),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  '${(widget.user.totalOrder??'0')} Orders',
                  style:  TextStyle(
                    color: Colors.black,
                    fontWeight:FontWeight.bold
                  ),
                )),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  '${(widget.user.totalSpend??0).toStringAsFixed(2)} AED',
                  style:  TextStyle(
                    color: Colors.black,
                      fontWeight:FontWeight.bold
                  ),
                )),
            // Flexible(
            //     flex: 1,
            //     fit: FlexFit.tight,
            //     child: Text(
            //       widget.user.createdAt.toDate().toString(),
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: const TextStyle(
            //         color: Colors.black,
            //       ),
            //     )),
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
                        onTap: () async {
                          Get.find<CheckoutController>()
                              .getAllAddressForUser(userId: widget.user.id);
                          Get.find<AdminController>().getAllInvoiceForUser(userId: widget.user.id);
                          Get.to(() => UsersInfo(
                                user: widget.user,
                              ));
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
                    ];
                  },
                )),
          ],
        ),
      ),
    );
  }
}

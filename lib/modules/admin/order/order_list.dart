import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/admin/order/temp_order.dart';
import 'package:sumer/util/text_util.dart';
import '../../../util/colors.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

var adminController = Get.find<AdminController>();
TextEditingController searchController = TextEditingController();
FocusNode search = FocusNode();
final ScrollController _scrollController = ScrollController();
bool isSearch = false;
bool isAll = false;
List<String> list = ['5', '10', '20', '30', '50'];

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    search = FocusNode();
    adminController.currentPage.value = 0;
    adminController.itemsPerPage.value = 10;
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
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
            color: Colors.grey.shade200),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtil(
                      text: 'Orders',
                      size: 20,
                    ),
                    SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  int totalPages = (adminController.allInvoicesFilter.length /
                          adminController.itemsPerPage.value)
                      .ceil();
                  var paginatedProducts = adminController.allInvoicesFilter
                      .skip(adminController.currentPage.value *
                          adminController.itemsPerPage.value)
                      .take(adminController.itemsPerPage.value)
                      .toList();

                  return Container(
                    width: width > 700 ? width / 1.1 : 900,
                    decoration: BoxDecoration(
                      boxShadow: [ BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 3.0),
                      ),],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isSearch
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width / 1.5,
                                  child: TextFormField(
                                    controller: searchController,
                                    focusNode: search,
                                    autofocus: false,
                                    cursorColor: secondaryColor,
                                    style: TextStyle(
                                        color: Colors.black.withAlpha(204)),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black54),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black54),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                              color: Colors.black54
                                                  .withAlpha(204)),
                                        ),
                                        hintText: 'Search',
                                        suffixIcon: searchController
                                                .text.isEmpty
                                            ? null
                                            : IconButton(
                                                onPressed: () {
                                                  searchController.clear();
                                                  adminController
                                                      .filterInvoices('');
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.circleXmark,
                                                  color: Colors.redAccent,
                                                )),
                                        icon: IconButton(
                                            onPressed: () {
                                              searchController.clear();
                                              adminController
                                                  .filterInvoices('');
                                              setState(() {
                                                isSearch = !isSearch;
                                              });
                                            },
                                            icon: Icon(Icons.close))),
                                    onChanged: (value) {
                                      adminController.filterInvoices(value);
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 5,
                              ),
                        !isSearch
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                overlayColor:
                                                    WidgetStateColor.resolveWith(
                                                        (s) => secondaryColor
                                                            .withAlpha(25)),
                                                backgroundColor:
                                                    WidgetStateColor.resolveWith(
                                                  (states) =>
                                                      Get.find<AdminController>()
                                                              .isAll
                                                              .value
                                                          ? Colors.grey
                                                              .withAlpha(25)
                                                          : Colors.white,
                                                )),
                                            onPressed: () async {
                                              setState(() {
                                                Get.find<AdminController>()
                                                    .isAll(true);
                                                Get.find<AdminController>()
                                                    .getAllInvoice();
                                              });
                                            },
                                            child: Text(
                                              'All ${Get.find<AdminController>().isAll.value ? "(${adminController.allInvoicesFilter.length})" : ""}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                  fontSize: 12
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton.icon(
                                          style: ButtonStyle(
                                              overlayColor:
                                                  WidgetStateColor.resolveWith(
                                                      (s) => secondaryColor
                                                          .withAlpha(25)),
                                              backgroundColor:
                                                  WidgetStateColor.resolveWith(
                                                (states) =>
                                                    !Get.find<AdminController>()
                                                            .isAll
                                                            .value
                                                        ? Colors.grey.withAlpha(25)
                                                        : Colors.white,
                                              )),
                                          onPressed: () {
                                            setState(() {
                                              Get.find<AdminController>()
                                                  .isAll(false);
                                              Get.find<AdminController>()
                                                  .getAllInvoice();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.archive_outlined,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                          label: Text(
                                            'Archived ${!Get.find<AdminController>().isAll.value ? "(${adminController.allInvoicesFilter.length})" : ""}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child:Transform.scale(
                                          scale: 0.8,
                                          child: Checkbox(value: adminController.isUnRead.value, onChanged: (v)async{
                                            setState(() {
                                              adminController.isUnRead.value = v!;
                                            });
                                           await adminController.getAllInvoice();
                                          } , activeColor: secondaryColor, shape: CircleBorder(),),
                                        ),


                                      ),
                                      Text(
                                        "UnRead",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                        shape: WidgetStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                                          overlayColor:
                                              WidgetStateColor.resolveWith(
                                                  (s) => secondaryColor
                                                      .withAlpha(25)),
                                          backgroundColor:
                                              WidgetStateColor.resolveWith(
                                            (states) => Colors.white,
                                          )),
                                      onPressed: () {
                                        setState(() {
                                          isSearch = !isSearch;
                                        });
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.searchengin,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                      label: Text(
                                        'Search',
                                        style: TextStyle(
                                          color: Colors.black,
                                            fontSize: 12
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(
                                height: 5,
                              ),

                        Divider(),
                        Scrollbar(
                          controller: _scrollController,
                          scrollbarOrientation: ScrollbarOrientation.top,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: width > 700 ? width / 1.1 : 900,
                              child: (adminController.isLoadingOrder.value)
                                  ? SizedBox(
                                      height: 300,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: secondaryColor,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        adminController.selectOrder.isNotEmpty
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    ElevatedButton.icon(
                                                      style: ButtonStyle(
                                                          overlayColor: WidgetStateColor
                                                              .resolveWith((s) =>
                                                                  secondaryColor
                                                                      .withAlpha(
                                                                          25)),
                                                          backgroundColor:
                                                              WidgetStateColor
                                                                  .resolveWith(
                                                            (states) =>
                                                                Colors.white,
                                                          )),
                                                      onPressed: () {
                                                        setState(() {
                                                          adminController
                                                              .selectOrder
                                                              .clear();
                                                          isAll = false;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        isAll
                                                            ? Icons
                                                                .check_circle_outline
                                                            : Icons
                                                                .remove_circle_outline,
                                                        color: secondaryColor,
                                                      ),
                                                      label: Text(
                                                        ' (${adminController.selectOrder.length}) Selected',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuButton(
                                                      color: Colors.white,
                                                      tooltip: "More Option",
                                                      iconColor: Colors.black,
                                                      itemBuilder: (BuildContext context) {
                                                        return  <PopupMenuItem<Widget>>[
                                                          PopupMenuItem<Widget>(
                                                            onTap: () async{
                                                              await Get.find<AdminController>().readInvoices(
                                                                invoiceIds: adminController.selectOrder,
                                                                read: true,
                                                              );
                                                              Get.find<AdminController>().getAllInvoice();
                                                              adminController.selectOrder.clear();
                                                              isAll = false;
                                                              setState(() {
                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon( Icons.mark_email_read_outlined, color: secondaryColor),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text("Read", style: TextStyle(color: Colors.black)),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem<Widget>(
                                                            onTap: () async{
                                                              await Get.find<AdminController>().readInvoices(
                                                                invoiceIds: adminController.selectOrder,
                                                                read: false,
                                                              );
                                                              Get.find<AdminController>().getAllInvoice();
                                                              adminController.selectOrder.clear();
                                                              isAll = false;
                                                              setState(() {

                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon( Icons.mark_email_unread_rounded  , color: secondaryColor),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text("UnRead", style: TextStyle(color: Colors.black)),
                                                              ],
                                                            ),
                                                          ),
                                                          PopupMenuItem<Widget>(
                                                            onTap: () async {
                                                              await Get.find<AdminController>().archivedInvoices(
                                                                invoiceIds: adminController.selectOrder,
                                                                archived:!Get.find<AdminController>().isAll.value ?false: true,
                                                              );
                                                              Get.find<AdminController>().getAllInvoice();
                                                              adminController.selectOrder.clear();
                                                              isAll = false;
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Icon(!Get.find<AdminController>().isAll.value ? Icons.unarchive : Icons.archive, color: secondaryColor),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(!Get.find<AdminController>().isAll.value ? "UnArchived" :"Archived" ,
                                                                    style: TextStyle(color: Colors.black)),
                                                              ],
                                                            ),
                                                          ),
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
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Checkbox(
                                                            activeColor:
                                                                secondaryColor,
                                                            value: isAll,
                                                            onChanged: (v) {
                                                              setState(() {
                                                                for (var i
                                                                    in paginatedProducts) {
                                                                  adminController
                                                                      .selectOrder
                                                                      .add(i.id ??
                                                                          '');
                                                                  isAll = true;
                                                                }
                                                              });
                                                            })),
                                                    Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Order No.',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Customer',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Total',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Payment',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Ship Type',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Items',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'Ship Status',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                    const Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          '',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                        const Divider(
                                          color: Colors.black54,
                                          thickness: 2,
                                        ),
                                        adminController.allInvoices.isEmpty
                                            ? SizedBox(
                                                height: 300,
                                                child: Center(
                                                  child: TextUtil(
                                                    text: 'NO ORDERS',
                                                    size: 30,
                                                  ),
                                                ),
                                              )
                                            : ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    paginatedProducts.length,
                                                itemBuilder: (context, index) {
                                                  return TempOrder(
                                                    invoice: paginatedProducts[index],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return const Divider();
                                                },
                                              ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        totalPages != 0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        TextUtil(
                                          text: 'Order Per Page  ',
                                          color: Colors.grey,
                                        ),
                                        DropdownButton<String>(
                                          elevation: 24,
                                          dropdownColor: Colors.white,
                                          value: adminController
                                              .itemsPerPage.value
                                              .toString(),
                                          items: list
                                              .map((e) =>
                                                  DropdownMenuItem<String>(
                                                    value: e,
                                                    // تأكد من تعيين قيمة العنصر
                                                    child: Text(e),
                                                  ))
                                              .toList(),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              adminController.itemsPerPage
                                                  .value = int.parse(newValue);
                                              adminController.currentPage.value = 0;
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: adminController
                                                      .currentPage.value ==
                                                  0
                                              ? null
                                              : () {
                                                  setState(() {
                                                    adminController
                                                        .currentPage.value -= 1;
                                                  });
                                                },
                                          icon: Icon(Icons.arrow_back_ios),
                                          color: adminController
                                                      .currentPage.value ==
                                                  0
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: DropdownButton<String>(
                                            elevation: 24,
                                            dropdownColor: Colors.white,
                                            value: adminController
                                                .currentPage.value
                                                .toString(),
                                            items: List.generate(
                                                    totalPages,
                                                    (index) =>
                                                        (index).toString())
                                                .map((e) =>
                                                    DropdownMenuItem<String>(
                                                      value: e,
                                                      // تأكد من تعيين قيمة العنصر
                                                      child: Text(
                                                          (int.parse(e) + 1)
                                                              .toString()),
                                                    ))
                                                .toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                                adminController
                                                        .currentPage.value =
                                                    int.parse(newValue);
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: adminController
                                                          .currentPage.value +
                                                      1 <
                                                  totalPages
                                              ? () {
                                                  if (totalPages != 0) {
                                                    if (adminController
                                                                .currentPage
                                                                .value +
                                                            1 <
                                                        totalPages) {
                                                      setState(() {
                                                        adminController
                                                            .currentPage
                                                            .value += 1;
                                                      });
                                                    }
                                                  }
                                                }
                                              : null,
                                          icon: Icon(Icons.arrow_forward_ios),
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

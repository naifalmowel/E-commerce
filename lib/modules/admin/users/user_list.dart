import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/admin/admin_controller.dart';
import 'package:sumer/modules/admin/users/temp_user.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/text_util.dart';

import 'add_users.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

var adminController = Get.find<AdminController>();
final ScrollController _scrollController = ScrollController();
TextEditingController searchController = TextEditingController();
class _UsersListState extends State<UsersList> {

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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUtil(
                      text: 'Users',
                      size: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(() => const AddUsers());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        child:  Text(
                          'Add New Users',
                          style: TextStyle(color: secondaryColor),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => adminController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      )
                    : adminController.users.isEmpty
                        ? Center(
                            child: TextUtil(
                              text: 'NO Users',
                              size: 30,
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withAlpha(50),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.withAlpha(128)),
                                  ),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.warning,
                                      size: 40,
                                      color: Colors.redAccent.withAlpha(178),
                                    ),
                                    title: Text(
                                      'Editing and deletion must be done by the user himself for security reasons.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black.withAlpha(204),
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              ),
                              Scrollbar(
                                controller: _scrollController,
                                scrollbarOrientation: ScrollbarOrientation.top,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    width: width > 700 ? width / 1.1 : 700,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [ BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10.0,
                                          offset: Offset(0.0, 3.0),
                                        ),],
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: TextFormField(
                                            controller: searchController,
                                            style: TextStyle(
                                                color:
                                                    Colors.black.withAlpha(204)),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: secondaryColor),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: secondaryColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide(
                                                    color: secondaryColor
                                                        .withAlpha(204)),
                                              ),
                                              hintText: 'Search',
                                              suffixIcon: searchController.text.isEmpty
                                                  ? null
                                                  : IconButton(
                                                  onPressed: () {
                                                    searchController.clear();
                                                    adminController
                                                        .filterUserPlayer('');
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                    FontAwesomeIcons.circleXmark,
                                                    color: Colors.redAccent,
                                                  )),
                                            ),
                                            onChanged: (value) => adminController
                                                .filterUserPlayer(value),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text(
                                                    'UserName (${adminController.usersFilter.length})',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text(
                                                    'Email',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text(
                                                    'PhoneNO',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text(
                                                    'Orders',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text(
                                                    'Total Spending',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              const Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Text(
                                                    '',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color: Colors.black54,
                                          thickness: 2,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount:
                                              adminController.usersFilter.length,
                                          itemBuilder: (context, index) {
                                            return TempUser(
                                              user: adminController
                                                  .usersFilter[index],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context, int index) {
                                            return const Divider();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

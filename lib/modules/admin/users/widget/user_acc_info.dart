import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/user_model.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';


class UserAccountPage extends StatefulWidget {
   const UserAccountPage({super.key, required this.user});
final UserModel user;
  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

final userController = Get.find<UserController>();

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'User Account',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20 , fontWeight: FontWeight.bold),
              ),
            ),
            infoCard(
              title: 'Name',
              subTitle: widget.user.username,
            ),
            infoCard(
              title: 'E-Mail Address',
              subTitle: widget.user.email,
            ),
            infoCard(
              title: 'Password',
              subTitle: ''.padLeft(
                  widget.user.password
                      .length,
                  '*'),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard({
    required String title,
    required String subTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width < 800 ? 400 : 600,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
            Border.all(color: Colors.blueAccent.withOpacity(0.2), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black45),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

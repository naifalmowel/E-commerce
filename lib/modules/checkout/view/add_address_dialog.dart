import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/model/address_model.dart';
import 'package:sumer/model/user_model.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';

import '../../../global/custom_drop_down.dart';
import '../../../util/constant.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key, required this.address, this.user});

  final Address? address;
  final UserModel? user;

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  String? _address, _apartment, _city, _postalCode, _secondaryPhone;
  final controller = Get.find<CheckoutController>();
  final List<String> _countries = [
    'United Arab Emirates',
  ];
  final List<String> _cities = [
    'Abu Dhabi - أبو ظبي',
    'Dubai - دبي',
    'Sharjah - الشارقة',
    'Ajman - عجمان',
    'Fujairah - الفجيرة',
    'Ras Al Khaimah - رأس الخيمة',
    'Umm Al Quwain - أم القيوين',
  ];
  bool loading = false;
  TextEditingController address = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController secondaryPhone = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    if (widget.address != null) {
      address.text = widget.address!.address;
      apartment.text = widget.address!.apartment;
      controller.country.value = widget.address!.country;
      postalCode.text = widget.address!.postalCode;
      secondaryPhone.text = widget.address!.secondaryPhone;
      _city = widget.address!.city;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: width > 750 ? width / 1.8 : width / 1.1,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomDropDownButton(
                            title: 'Country',
                            hint: 'Country',
                            value: controller.country.value.isEmpty
                                ? null
                                : controller.country.value,
                            items: _countries,
                            onChange: (v) {
                              controller.country.value = v!;
                              _city = '';
                            },
                            width: width < 750 ? 150 : 300,
                            height: 30,
                            textEditingController: searchController,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(() => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomDropDownButton(
                                title: 'City/Governorate',
                                hint: 'City/Governorate',
                                value: (_city ?? '').isEmpty ? null : _city,
                                items: controller.country.value
                                        .contains('Emirates')
                                    ? _cities
                                    : [],
                                onChange: (v) {
                                  _city = v!;
                                },
                                width: width < 750 ? 150 : 300,
                                height: 30,
                                textEditingController: searchController,
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      controller: address,
                      cursorColor: Colors.blueAccent,
                      decoration: InputDecoration(
                        label: const Text('Address'),
                        labelStyle: const TextStyle(color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                      onSaved: (value) => _address = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      controller: apartment,
                      decoration: InputDecoration(
                        label: const Text('Apartment/Suite/Unit'),
                        labelStyle: const TextStyle(color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Apartment/Suite/Unit';
                        }
                        return null;
                      },
                      onSaved: (value) => _apartment = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      controller: postalCode,
                      cursorColor: Colors.blueAccent,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        label: const Text('Postal Code'),
                        labelStyle: const TextStyle(color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the postal code';
                        }
                        return null;
                      },
                      onSaved: (value) => _postalCode = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      controller: secondaryPhone,
                      cursorColor: Colors.blueAccent,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\+?[0-9]*$'))
                      ],
                      decoration: InputDecoration(
                        label: const Text('Secondary Phone Number'),
                        labelStyle: const TextStyle(color: Colors.blueAccent),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Colors.blueAccent.withOpacity(0.5))),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => _secondaryPhone = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      loading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ))
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.blueAccent.withOpacity(0.8))),
                              onPressed: widget.address == null
                                  ? _saveAddress
                                  : _editAddress,
                              child: const Text(
                                'Save Address',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.redAccent)),
                        child: const Text(
                          'Cansel',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
            ))
      ],
    );
  }

  Future _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      if ((_city ?? '').isEmpty || controller.country.isEmpty) {
        Constant.showSnakeBarError(
            context, 'Please , Select Country And City , ');
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      String userId = widget.user != null
          ? widget.user!.id
          : Get.find<SharedPreferences>().getString("userId") ?? '';
      var data = {
        'address': _address,
        'apartment': _apartment,
        'country': controller.country.value,
        'city': _city,
        'postalCode': _postalCode ?? '',
        'secondaryPhone': _secondaryPhone ?? '',
        'createdAt': DateTime.now(),
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .add(data);
      widget.user != null
          ? await Get.find<CheckoutController>()
          .getAllAddressForUser(userId: widget.user!.id)
          : await Get.find<CheckoutController>().getAllAddress();

      if (!mounted) {
        return;
      }
      Constant.showSnakeBarSuccess(context, 'Address saved successfully');
      setState(() {
        loading = false;
      });
      Get.back();
    }
  }

  Future _editAddress() async {
    if (_formKey.currentState!.validate()) {
      if (_city!.isEmpty || controller.country.isEmpty) {
        Constant.showSnakeBarError(
            context, 'Please , Select Country And City , ');
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      String userId = widget.user != null
          ? widget.user!.id
          : Get.find<SharedPreferences>().getString("userId") ?? '';
      var data = {
        'address': _address,
        'apartment': _apartment,
        'country': controller.country.value,
        'city': _city,
        'postalCode': _postalCode ?? '',
        'secondaryPhone': _secondaryPhone ?? '',
        'createdAt': widget.address!.createdAt,
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('addresses')
          .doc(widget.address!.id)
          .update(data);
      widget.user != null
          ? await Get.find<CheckoutController>()
          .getAllAddressForUser(userId: widget.user!.id)
          : await Get.find<CheckoutController>().getAllAddress();
      if (!mounted) {
        return;
      }
      Constant.showSnakeBarSuccess(context, 'Address saved successfully');
      setState(() {
        loading = false;
      });
      Get.back();
    }
  }
}

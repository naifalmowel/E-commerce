// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/util/text_util.dart';

class CustomDropDownButton extends StatefulWidget {
  CustomDropDownButton(
      {required this.title,
      required this.hint,
      required this.items,
      this.value,
      this.withOutValue,
      this.reset,
      required this.onChange,
      required this.width,
      required this.height,
      required this.textEditingController,
      super.key});

  final String title;
  final String hint;
  final List<String> items;
  String? value;
  final Function(String?) onChange;
  final double width;
  final double height;
  final bool? withOutValue;
  final VoidCallback? reset;

  TextEditingController textEditingController;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? valuee;
  var init = true;

  @override
  void initState() {
    if (init) {
      valuee = null;
      init = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Center(
          child: TextUtil(
            text: widget.hint,
            size: 15,
            align: TextAlign.center,
            color:widget.items.isEmpty?Colors.black54 :  Colors.blueAccent,
          ),
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Center(
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ))
            .toList(),
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.value = value;
            valuee = value;
          });
          widget.onChange(value);
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          width: widget.width
        ),
        iconStyleData:
            const IconStyleData(iconEnabledColor: Colors.blueAccent , iconDisabledColor: Colors.black54),
        dropdownStyleData: const DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          maxHeight: 200,
          width: 200
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,

        ),
        dropdownSearchData: DropdownSearchData(
          searchController: widget.textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search...'.tr,
                hintStyle: const TextStyle(fontSize: 12),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(30)),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            final myItem = widget.items
                .firstWhere((element) => element == item.value);
            return ((myItem
                    .toString()
                    .toLowerCase()
                    .toString()
                    .contains(searchValue.toLowerCase().toString())) ||
                (item.value
                    .toString()
                    .toLowerCase()
                    .toString()
                    .contains(searchValue.toLowerCase().toString())));
          },
        ),
        isExpanded: true,
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.textEditingController.clear();
          }
        },
      ),
    );
  }
}

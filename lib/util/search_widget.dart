// Custom Suggestions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sumer/model/product_model.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/modules/product/view/product_details.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

TextEditingController searchController = TextEditingController();

class _SearchWidgetState extends State<SearchWidget> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    products = Get.find<ProductController>().allProducts;
  }

  @override
  Widget build(BuildContext context) {
    return SearchField<Product>(
      controller: searchController,
      onTap: () async {
        if (Get.isRegistered<ProductController>()) {
          await Get.find<ProductController>().getAllProduct();
        }
      },
      maxSuggestionsInViewPort: 5,
      itemHeight: 80,
      hint: 'Search for Products',
      suggestionsDecoration: SuggestionDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        color: Colors.grey,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      suggestionItemDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.0)),
      searchInputDecoration: SearchInputDecoration(
          suffixIcon: const Icon(Icons.search_rounded),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: IconButton(onPressed: (){
            searchController.clear();
            FocusScope.of(context).unfocus();
          }, icon: Icon(Icons.close)),
          focusedBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: Colors.grey.withOpacity(0.8),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(    borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
            borderRadius: BorderRadius.circular(8),)
      ),
      marginColor: Colors.white,
      onSearchTextChanged: (query) {
        if(query.isNotEmpty){
          final filter = products
              .where((element) =>
          element.brand.toLowerCase().contains(query.toLowerCase()) ||
              element.model.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return filter
              .map((e) => SearchFieldListItem<Product>(e.model,
              child: ProductTile(user: e), item: e))
              .toList();
        }else{
          return [];
        }

      },
      onSuggestionTap: (s) {
     if(mounted){
       searchController.clear();
       Get.to(() => ProductDetailScreen(
         product: s.item!, view: false,
       ));
     }
      },
      suggestions: products
          .map((e) => SearchFieldListItem<Product>(e.model,
              child: ProductTile(user: e), item: e))
          .toList(),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product user;

  const ProductTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        user.image,
        fit: BoxFit.fill,
        width: 55,
      ),
      title: Text(
        user.brand,
        style:  TextStyle(fontWeight: FontWeight.w600 , color:Colors.black),
      ),
      subtitle: Text(user.model,  style:  TextStyle(fontWeight: FontWeight.w600 , color:Colors.black),),
    );
  }
}

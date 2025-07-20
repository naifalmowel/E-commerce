import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';
import 'package:sumer/util/colors.dart';
import 'package:sumer/util/social_media.dart';
import '../../util/constant.dart';
import '../../util/scroll_config.dart';
import '../../util/search_widget.dart';
import '../../util/text_util.dart';
import '../admin/admin_controller.dart';
import '../carousel/carousel.dart';
import '../category/view/category_page.dart';
import '../footer/view/footer_page.dart';
import '../product/controller/product_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../product/view/products_page.dart';
import '../user/view/user_details.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final prefs = Get.find<SharedPreferences>();
  final productController = Get.find<ProductController>();
  final cartController = Get.find<CartController>();
  final userController = Get.find<UserController>();
  final ScrollController _scrollController = ScrollController();

  RangeValues _selectedPriceRange = RangeValues(
      (Get.find<SharedPreferences>().getDouble('lowPrice') ?? 0).toDouble(),
      (Get.find<SharedPreferences>().getDouble('topPrice') ?? 5000).toDouble());
  String sortValue = 'def';
  bool isSearch = false;

  @override
  void initState() {
    userController.getUserInfo();
    Get.find<CartController>().loadCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        drawer: _buildSideMenu(),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            await productController.getProductWithFilter(
                topPrice: _selectedPriceRange.end,
                lowPrice: _selectedPriceRange.start,
                catList: productController.selectedCategories);

            Get.find<AdminController>().getSocialMediaLinks();
            await categoryController.fetchCategories();
            sortValue = 'def';
            _sortList(sortValue);
            setState(() {});
          },
          color: secondaryColor,
          child: SingleChildScrollView(
              controller: _scrollController,
              child: Obx(() =>
                  Column(
                    children: [
                      width > 800
                          ? headerWidgetWeb()
                          : headerWidgetMobile(),
                      Get
                          .find<AdminController>()
                          .isLoadingC
                          .value
                          ||
                          categoryController.isLoading.value
                          ? SizedBox(
                        height: Get.height,
                        child: Center(
                          child: SpinKitWave(
                            color: secondaryColor
                            ,
                          ),
                        ),
                      )
                          : Column(
                        children: [
                          const CustomCarousel(),
                          const CategoryPage(),
                          Obx(
                                () =>
                            productController.catId.value == '0' ||
                                productController.catId.value == ''
                                ? Text(
                              'ALL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                                : Text(
                              categoryController.categories
                                  .firstWhere((element) =>
                              element.id ==
                                  productController.catId.value)
                                  .name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Builder(builder: (context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width / 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                            WidgetStateColor.resolveWith(
                                                    (states) => Colors.white),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.filter_alt,
                                                  color: secondaryColor,
                                                ),
                                                Text(
                                                  "FILTER",
                                                  style: TextStyle(
                                                      color: secondaryColor),
                                                ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Obx(
                                            () =>
                                        productController
                                            .selectedCategories.isEmpty &&
                                            ((Get.find<SharedPreferences>()
                                                .getDouble(
                                                'lowPrice') ??
                                                0) ==
                                                0 &&
                                                (Get.find<SharedPreferences>()
                                                    .getDouble(
                                                    'topPrice') ??
                                                    5000) ==
                                                    5000)
                                            ? SizedBox()
                                            : InkWell(
                                          onTap: () async {
                                            Get.find<SharedPreferences>()
                                                .remove('lowPrice');
                                            Get.find<SharedPreferences>()
                                                .remove('topPrice');
                                            _selectedPriceRange =
                                            const RangeValues(0, 5000);
                                            productController
                                                .selectedCategories
                                                .clear();
                                            await productController
                                                .getProductWithFilter(
                                                catList: [],
                                                lowPrice: null,
                                                topPrice: null);
                                            _sortList(sortValue);
                                            setState(() {});
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.clear,
                                                color: errorColor,
                                                size: 20,
                                              ),
                                              TextUtil(
                                                text: "Clear All Filter",
                                                color: errorColor,
                                                size: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent),
                                    child: PopupMenuButton<String>(
                                      onSelected: (v) {
                                        sortValue = v;
                                        _sortList(v);
                                      },
                                      shadowColor: Colors.grey,
                                      tooltip: 'Sort',
                                      shape: const OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide:
                                          BorderSide(color: Colors.black38)),
                                      color: Colors.white,
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          const PopupMenuItem(
                                            value: 'def',
                                            child: Text('Default'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'name',
                                            child: Text('Name'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'price_high_to_low',
                                            child: Text('Price(High to Low)'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'price_low_to_high',
                                            child: Text('Price(Low to High)'),
                                          ),
                                        ];
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                sortValue == 'def'
                                                    ? 'Sort By'
                                                    : sortValue,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Icon(
                                                Icons.sort,
                                                color: Colors.black,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          listFilter(),
                          const ProductPage(),
                        ],
                      ),
                      const Footer(),
                    ],
                  ),)
          ),
        ),
      ),
    );
  }

  Widget _buildSideMenu() {
    return Obx(() =>
        Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 80,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(178),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ...categoryController.categories
                  .where((value) => value.id != '0')
                  .map((key) {
                return CheckboxListTile(
                  title: Text(key.name),
                  activeColor: secondaryColor,
                  value: productController.selectedCategories
                      .contains(key.id.toString()),
                  onChanged: (bool? value) async {
                    setState(() {
                      if (productController.selectedCategories
                          .contains(key.id.toString())) {
                        productController.selectedCategories
                            .remove(key.id.toString());
                      } else {
                        productController.selectedCategories
                            .add(key.id.toString());
                      }
                    });
                    await productController.getProductWithFilter(
                        catList: productController.selectedCategories,
                        lowPrice: _selectedPriceRange.start,
                        topPrice: _selectedPriceRange.end);
                    _sortList(sortValue);
                  },
                );
              }),
              ListTile(
                title: const Text('Price Range:'),
                subtitle: RangeSlider(
                  values: _selectedPriceRange,
                  min: 0,
                  max: 5000,
                  divisions: 100,
                  activeColor: secondaryColor.withAlpha(178),
                  labels: RangeLabels(
                    '${_selectedPriceRange.start.round()} AED',
                    '${_selectedPriceRange.end.round()} AED',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _selectedPriceRange = values;
                    });
                  },
                ),
              ),
              Center(
                  child: Text(
                    'From ${_selectedPriceRange.start
                        .round()} To ${_selectedPriceRange.end.round()}  AED',
                    style: TextStyle(
                        color: secondaryColor.withAlpha(178),
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() =>
                productController.isLoading.value
                    ? Center(
                    child: CircularProgressIndicator(
                      color: secondaryColor.withAlpha(178),
                    ))
                    : Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      Scaffold.of(context).closeDrawer();
                      Get.find<SharedPreferences>().remove('catList');
                      Get.find<SharedPreferences>().remove('lowPrice');
                      Get.find<SharedPreferences>().remove('topPrice');
                      Get.find<SharedPreferences>().setStringList(
                          'catList',
                          productController.selectedCategories);
                      Get.find<SharedPreferences>().setDouble(
                          'lowPrice', _selectedPriceRange.start);
                      Get.find<SharedPreferences>()
                          .setDouble('topPrice', _selectedPriceRange.end);
                      await productController.getProductWithFilter(
                          catList: productController.selectedCategories,
                          lowPrice: _selectedPriceRange.start,
                          topPrice: _selectedPriceRange.end);
                      _sortList(sortValue);
                      setState(() {});
                    },
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith(
                                (states) => secondaryColor.withAlpha(178))),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                })),
              ),
            ],
          ),
        ));
  }

  Widget listFilter() {
    return Obx(() =>
    categoryController.isLoading.value
        ? const CircularProgressIndicator()
        : Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .width / 22,
          vertical: 2),
      child: Column(
        children: [
          productController.selectedCategories.isEmpty
              ? SizedBox()
              : SizedBox(
            height: 50,
            child: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount:
                productController.selectedCategories.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productController
                                .selectedCategories.isEmpty
                                ? ''
                                : categoryController.categories
                                .firstWhere((element) =>
                            element.id.toString() ==
                                productController
                                    .selectedCategories[
                                index])
                                .name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme
                                    .of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color!),
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30)),
                        onTap: () async {
                          productController.selectedCategories
                              .removeAt(index);
                          await productController
                              .getProductWithFilter(
                              catList: productController
                                  .selectedCategories,
                              lowPrice:
                              _selectedPriceRange.start,
                              topPrice:
                              _selectedPriceRange.end);
                          setState(() {});
                        },
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.blueAccent,
                          child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 13,
                              )),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          (Get.find<SharedPreferences>().getDouble('lowPrice') ?? 0) ==
              0 &&
              (Get.find<SharedPreferences>().getDouble('topPrice') ??
                  5000) ==
                  5000
              ? const SizedBox()
              : Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "From ${(Get.find<SharedPreferences>().getDouble(
                        'lowPrice') ?? 0).toStringAsFixed(0)} AED",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black54),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "To ${(Get.find<SharedPreferences>().getDouble(
                        'topPrice') ?? 5000).toStringAsFixed(0)} AED",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              IconButton(
                  onPressed: () async {
                    Get.find<SharedPreferences>()
                        .remove('lowPrice');
                    Get.find<SharedPreferences>()
                        .remove('topPrice');
                    _selectedPriceRange =
                    const RangeValues(0, 5000);
                    await productController.getProductWithFilter(
                        catList:
                        productController.selectedCategories,
                        lowPrice: null,
                        topPrice: null);
                    _sortList(sortValue);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.redAccent,
                  ))
            ],
          ),
        ],
      ),
    ));
  }

  void _sortList(String sortV) {
    setState(() {
      if (sortV == 'name') {
        productController.products.sort((a, b) => a.brand.compareTo(b.brand));
      } else if (sortV == 'price_high_to_low') {
        productController.products.sort((a, b) =>
            ((b.offerPrice ?? 0) == 0
                ? b.price
                : b.offerPrice!)
                .compareTo(
                ((a.offerPrice ?? 0) == 0 ? a.price : a.offerPrice!)));
      } else if (sortV == 'price_low_to_high') {
        productController.products.sort((a, b) =>
            ((a.offerPrice ?? 0) == 0
                ? a.price
                : a.offerPrice!)
                .compareTo(
                ((b.offerPrice ?? 0) == 0 ? b.price : b.offerPrice!)));
      } else if (sortV == 'def') {
        productController.getProductWithFilter(
            catList: productController.selectedCategories,
            lowPrice: _selectedPriceRange.start,
            topPrice: _selectedPriceRange.end);
      }
    });
  }

  Widget headerWidgetMobile() {
    return Obx(
          () =>
          Column(
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: Get.width / 22, vertical: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userController.name.value == ''
                        ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(secondaryColor)),
                        onPressed: () {
                          Get.toNamed('/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ))
                        : Tooltip(
                        message:
                        '${userController.name.value} \n ${userController.email
                            .value}',
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.white.withAlpha(76),
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Get.find<CheckoutController>().getAllAddress();
                              Get.find<AdminController>().getAllInvoiceForUser(
                                  userId: userController.userId.value);
                              Get.to(() =>
                              const UserDetails(
                                showBack: true,
                              ));
                            },
                            child: CircleAvatar(
                              backgroundColor: secondaryColor.withAlpha(178),
                              radius: 20,
                              child: Text(
                                userController.name.value[0].toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                    Constant.logo(),
                    Center(
                      child: badges.Badge(
                        position: badges.BadgePosition.topEnd(top:-5, end: -2),
                        showBadge: cartController.cartItemsQTY.value != 0,
                        badgeContent: Text(
                          '${cartController.cartItemsQTY.value}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: IconButton(
                            tooltip: 'Cart',
                            color: Theme
                                .of(context)
                                .textTheme
                                .displayLarge!
                                .color,
                            onPressed: () {
                              Get.toNamed('/cart');
                            },
                            splashColor: Colors.white.withAlpha(78),
                            // لون التأثير عند النقر
                            highlightColor: Colors.transparent,
                            iconSize: 30,
                            icon: Icon(Icons.shopping_cart)),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width / 22),
                child: SearchWidget(),
              ),
              Divider(),
            ],
          ),
    );
  }

  Widget headerWidgetWeb() {
    return Obx(
          () =>
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 22, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Get
                              .find<AdminController>()
                              .isLoading
                              .value ||
                              Get
                                  .find<AdminController>()
                                  .isLoadingC
                                  .value
                              ? Center(
                            child: CircularProgressIndicator(
                              color: secondaryColor,
                            ),
                          )
                              : Get
                              .find<AdminController>()
                              .withoutLogo
                              .value
                              ? TextUtil(
                            text: Get
                                .find<AdminController>()
                                .listCarousel
                                .isNotEmpty
                                ? Get
                                .find<AdminController>()
                                .listCarousel
                                .last
                                .title
                                : "LOGO",
                            size: 25,
                          )
                              : Get
                              .find<AdminController>()
                              .logoImages
                              .value
                              .isNotEmpty
                              ? Image.network(
                            Get
                                .find<AdminController>()
                                .logoImages
                                .value,
                            width: 50,
                            // تأكد أن الحجم يتناسب مع `radius`
                            height: 50,
                            fit: BoxFit.cover,
                            // اجعل الصورة تغطي الدائرة بشكل جيد
                            errorBuilder:
                                (context, error, stackTrace) =>
                                Image.asset(
                                  'assets/image/logo.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                          )
                              : Image.asset(
                            'assets/image/logo.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(child: SearchWidget()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SocialMedia(),
                          Center(
                            child: badges.Badge(
                              position:
                              badges.BadgePosition.topEnd(top: -8, end: -2),
                              showBadge: cartController.cartItemsQTY.value != 0,
                              badgeContent: Text(
                                '${cartController.cartItemsQTY.value}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              child: IconButton(
                                  tooltip: 'Cart',
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  onPressed: () {
                                    Get.toNamed('/cart');
                                  },
                                  splashColor: Colors.white.withAlpha(78),
                                  // لون التأثير عند النقر
                                  highlightColor: Colors.transparent,
                                  iconSize: 35,
                                  icon: Icon(Icons.shopping_cart)),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          userController.name.value == ''
                              ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  WidgetStatePropertyAll(secondaryColor)),
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ))
                              : Tooltip(
                              message:
                              '${userController.name.value} \n ${userController
                                  .email.value}',
                              child: Center(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: Colors.white.withAlpha(76),
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Get.find<CheckoutController>()
                                        .getAllAddress();
                                    Get.find<AdminController>()
                                        .getAllInvoiceForUser(
                                        userId:
                                        userController.userId.value);
                                    Get.to(() =>
                                    const UserDetails(
                                      showBack: true,
                                    ));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                    secondaryColor.withAlpha(178),
                                    radius: 20,
                                    child: Text(
                                      userController.name.value[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider()
              ],
            ),
          ),
    );
  }
}

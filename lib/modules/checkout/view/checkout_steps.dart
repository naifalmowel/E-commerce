import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sumer/model/invoice_model.dart';
import 'package:sumer/modules/cart/controller/cart_controller.dart';
import 'package:sumer/modules/checkout/controller/checkout_controller.dart';
import 'package:sumer/modules/checkout/view/payment_page.dart';
import 'package:sumer/modules/checkout/view/success_add_bill.dart';
import 'package:sumer/util/text_util.dart';
import '../../../services/payment_methods/telr/telr_payment.dart';
import '../../../util/constant.dart';
import '../../footer/view/footer_page.dart';
import 'add_address_page.dart';
import 'cart_details.dart';
import 'delivery_page.dart';

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  StepperPageState createState() => StepperPageState();
}

class StepperPageState extends State<StepperPage> {
  int _currentStep = 0;
  bool show = false;
  final controller = Get.find<CartController>();
  final checkoutController = Get.find<CheckoutController>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: width > 750
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Theme(
                              data: ThemeData.fallback(useMaterial3: false),
                              child: SizedBox(
                                child: Stepper(
                                    currentStep: _currentStep,
                                    onStepTapped: (step) {
                                      setState(() {
                                        onTap(step);
                                      });
                                    },
                                    onStepContinue: onContinue,
                                    onStepCancel: () {
                                      if (_currentStep == 0) {
                                        Get.find<CheckoutController>()
                                            .selectedAddress
                                            .value = '';
                                        Get.back();
                                      }
                                      if (_currentStep > 0) {
                                        setState(() {
                                          _currentStep -= 1;
                                        });
                                      }
                                    },
                                    steps: _buildSteps(),
                                    controlsBuilder: (context, details) {
                                      return buildControlButton(
                                          context, details);
                                    },
                                    type: StepperType.vertical),
                              ),
                            ),
                          ),
                          const Expanded(child: CartDetails())
                        ],
                      ),
                      const Footer(),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: BackButton(
                              onPressed: () {
                                Get.back();
                              },
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextUtil(
                                      text: show
                                          ? 'Hide Order Details '
                                          : 'Show Order Details ',
                                    ),
                                    Icon(
                                      show
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.blueAccent.withOpacity(0.8),
                                    )
                                  ],
                                ),
                                Obx(
                                  () => TextUtil(
                                      text:
                                          "${controller.finalTotal.toStringAsFixed(2)} AED"),
                                )
                              ],
                            ),
                          ),
                        ),
                        show ? const CartDetails() : const SizedBox(),
                        Stepper(
                          currentStep: _currentStep,
                          onStepTapped: (step) {
                            setState(() {
                              onTap(step);
                            });
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          onStepContinue: onContinue,
                          onStepCancel: () {
                            if (_currentStep == 0) {
                              Get.find<CheckoutController>()
                                  .selectedAddress
                                  .value = '';
                              Get.back();
                            }
                            if (_currentStep > 0) {
                              setState(() {
                                _currentStep -= 1;
                              });
                            }
                          },
                          steps: _buildSteps(),
                          controlsBuilder: (context, details) {
                            return buildControlButton(context, details);
                          },
                          type: StepperType.vertical,
                        ),
                        const Footer(),
                      ],
                    ),
                  ),
                )),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: TextUtil(
          text: 'Cart',
        ),
        content: const AddAddressPage(),
        stepStyle: StepStyle(
          color: _currentStep >= 0 ? Colors.blueAccent : null,
          connectorColor:
              _currentStep >= 0 ? Colors.blueAccent.withOpacity(0.5) : null,
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: TextUtil(
          text: 'Delivery',
        ),
        stepStyle: StepStyle(
          color: _currentStep >= 1 ? Colors.blueAccent : null,
          connectorColor:
              _currentStep >= 1 ? Colors.blueAccent.withOpacity(0.5) : null,
        ),
        content: const DeliveryPage(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: TextUtil(
          text: 'Payment',
        ),
        stepStyle: StepStyle(
          color: _currentStep >= 2 ? Colors.blueAccent : null,
          connectorColor:
              _currentStep >= 2 ? Colors.blueAccent.withOpacity(0.5) : null,
        ),
        content: const PaymentPage(),
        isActive: _currentStep >= 2,
      ),
    ];
  }

  Widget buildControlButton(BuildContext c, ControlsDetails details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: details.onStepCancel,
              style: const ButtonStyle(
                  shape: WidgetStatePropertyAll(LinearBorder.none),
                  backgroundColor: WidgetStatePropertyAll(Colors.white70)),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Return',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
            _currentStep == 2
                ? Obx(() => ElevatedButton(
                      onPressed: () {
                        var selectPay =
                            Get.find<CheckoutController>().selectedPay.value;
                        if (selectPay.isEmpty) {
                          Constant.showSnakeBarError(
                              context, 'Please , Enter Your Payment Method !!');
                          return;
                        } else {
                          if (selectPay.contains('Cash')) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return Obx(() => AlertDialog(
                                      title: Obx(
                                        () => Center(
                                          child: TextUtil(
                                            text:
                                                'You will pay ${Get.find<CartController>().finalTotal.toStringAsFixed(2)} AED',
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            weight: false,
                                          ),
                                        ),
                                      ),
                                      icon: TextUtil(
                                        text:
                                            'Confirm Pay By Cash On Delivery (COD)',
                                        color: Colors.black45,
                                        align: TextAlign.center,
                                      ),
                                      content: TextUtil(
                                        text:
                                            'Are you sure you want to Pay By Cash On Delivery (COD)?',
                                        color: Colors.black,
                                        align: TextAlign.center,
                                      ),
                                      actions: Get.find<CheckoutController>()
                                              .submitLoading
                                              .value
                                          ? [
                                              Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ]
                                          : [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors
                                                                  .redAccent)),
                                                  child: const Text(
                                                    'Cansel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    var checkController =
                                                        Get.find<
                                                            CheckoutController>();
                                                    checkController
                                                        .submitLoading(true);
                                                    SalesInvoice sales =
                                                        await Get.find<
                                                                CheckoutController>()
                                                            .initBill(isCard: false);
                                                    bool result = await Get.find<
                                                            CheckoutController>()
                                                        .addInvoiceWithMaterialMovements(
                                                            sales.toMap());
                                                    if (result) {

                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      Get.to(()=> CheckoutConfirmationPage(invoiceData: checkController.salesPrint,));
                                                      Constant.showSnakeBarSuccess(
                                                          context,
                                                          'Your request has been successfully accepted ...');
                                                      await Get.find<CartController>().clearCart();
                                                      checkController
                                                          .submitLoading(false);
                                                    } else {
                                                      checkController
                                                          .submitLoading(false);
                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      Get.back();
                                                      Constant.showSnakeBarError(
                                                          context,
                                                          'Something went wrong please try again ...');
                                                    }
                                                  },
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors
                                                                  .blueAccent)),
                                                  child: const Text(
                                                    'PAY',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ],
                                    ));
                              },
                            );
                          }
                          else if (selectPay.contains('Card')) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return Obx(() => AlertDialog(
                                  title: Obx(
                                        () => Center(
                                      child: TextUtil(
                                        text:
                                        'You will pay ${Get.find<CartController>().finalTotal.toStringAsFixed(2)} AED',
                                        color:
                                        Colors.black.withOpacity(0.8),
                                        weight: false,
                                      ),
                                    ),
                                  ),
                                  icon: TextUtil(
                                    text:
                                    'Confirm Pay By Card',
                                    color: Colors.black45,
                                    align: TextAlign.center,
                                  ),
                                  content: TextUtil(
                                    text:
                                    'Are you sure you want to Pay By Card?',
                                    color: Colors.black,
                                    align: TextAlign.center,
                                  ),
                                  actions: Get.find<CheckoutController>()
                                      .submitLoading
                                      .value
                                      ? [
                                    Center(
                                        child:
                                        CircularProgressIndicator()),
                                  ]
                                      : [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: const ButtonStyle(
                                            backgroundColor:
                                            WidgetStatePropertyAll(
                                                Colors
                                                    .redAccent)),
                                        child: const Text(
                                          'Cansel',
                                          style: TextStyle(
                                              color: Colors.white),
                                        )),
                                    ElevatedButton(
                                        onPressed: () async {
                                          var checkController =
                                          Get.find<
                                              CheckoutController>();
                                          checkController
                                              .submitLoading(true);
                                          await TelrPayment.startPayment(context, 1.0);
                                          checkController
                                              .submitLoading(false);
                                          // SalesInvoice sales =
                                          // await Get.find<
                                          //     CheckoutController>()
                                          //     .initBill();
                                          // bool result = await Get.find<
                                          //     CheckoutController>()
                                          //     .addInvoiceWithMaterialMovements(
                                          //     sales.toMap());
                                          // if (result) {
                                          //
                                          //   if (!context.mounted) {
                                          //     return;
                                          //   }
                                          //   Get.to(()=> CheckoutConfirmationPage(invoiceData: checkController.salesPrint,));
                                          //   Constant.showSnakeBarSuccess(
                                          //       context,
                                          //       'Your request has been successfully accepted ...');
                                          //   await Get.find<CartController>().clearCart();
                                          //   checkController
                                          //       .submitLoading(false);
                                          // } else {
                                          //   checkController
                                          //       .submitLoading(false);
                                          //   if (!context.mounted) {
                                          //     return;
                                          //   }
                                          //   Get.back();
                                          //   Constant.showSnakeBarError(
                                          //       context,
                                          //       'Something went wrong please try again ...');
                                          // }
                                        },
                                        style: const ButtonStyle(
                                            backgroundColor:
                                            WidgetStatePropertyAll(
                                                Colors
                                                    .blueAccent)),
                                        child: const Text(
                                          'PAY',
                                          style: TextStyle(
                                              color: Colors.white),
                                        )),
                                  ],
                                ));
                              },
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              const WidgetStatePropertyAll(LinearBorder.none),
                          backgroundColor: WidgetStatePropertyAll(
                              Get.find<CheckoutController>().selectedPay.isEmpty
                                  ? Colors.grey
                                  : Colors.blueAccent.withOpacity(0.8))),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'PAY',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ))
                : ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ButtonStyle(
                        shape: const WidgetStatePropertyAll(LinearBorder.none),
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.blueAccent.withOpacity(0.8))),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void onContinue() async {
    if (_currentStep < 2) {
      if (_currentStep == 0) {
        if (Get.find<CheckoutController>().selectedAddress.value.isNotEmpty) {
          await Get.find<CheckoutController>().getAddressDetailsFromId(
              checkoutController.selectedAddress.value);
          setState(() {
            _currentStep += 1;
          });
        } else {
          Constant.showSnakeBarError(context, 'Please Enter Your Address !!');
        }
      } else if (_currentStep == 1) {
        if (Get.find<CheckoutController>().selectedShip.value.isNotEmpty) {
          await Get.find<CheckoutController>().getAddressDetailsFromId(
              checkoutController.selectedAddress.value);
          setState(() {
            _currentStep += 1;
          });
        } else {
          Constant.showSnakeBarError(
              context, 'Please Enter Your Shipping Type !!');
        }
      }
    }
  }

  void onTap(int step) async {
    if (_currentStep == 0) {
      if (Get.find<CheckoutController>().selectedAddress.value.isNotEmpty) {
        await Get.find<CheckoutController>()
            .getAddressDetailsFromId(checkoutController.selectedAddress.value);
        setState(() {
          _currentStep = step;
        });
      } else {
        Constant.showSnakeBarError(context, 'Please Enter Your Address !!');
      }
    } else if (_currentStep == 1) {
      if (step == 0) {
        setState(() {
          _currentStep = 0;
        });
      } else {
        if (Get.find<CheckoutController>().selectedShip.value.isNotEmpty) {
          await Get.find<CheckoutController>().getAddressDetailsFromId(
              checkoutController.selectedAddress.value);
          setState(() {
            _currentStep = step;
          });
        } else {
          Constant.showSnakeBarError(
              context, 'Please Enter Your Shipping Type !!');
        }
      }
    } else {
      setState(() {
        _currentStep = step;
      });
    }
  }
}

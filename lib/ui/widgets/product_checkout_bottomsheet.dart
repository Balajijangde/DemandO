import 'package:demando/AppConstants.dart';
import 'package:demando/ui/viewmodels/product_checkout_bottomsheet_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import 'package:demando/ui/widgets/app_button2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductCheckoutBottomSheet extends StatefulWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  ProductCheckoutBottomSheet({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  _ProductCheckoutBottomSheetState createState() =>
      _ProductCheckoutBottomSheetState();
}

class _ProductCheckoutBottomSheetState
    extends State<ProductCheckoutBottomSheet> {
  GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductCheckoutBottomSheetViewModel>.reactive(
        builder: (context, model, child) => model.orderPlaced
            ? (Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Lottie.asset("animations/done.json",
                          width: 130, fit: BoxFit.fill),
                      Text("Order Placed",
                          style: TextStyle(
                              color: Appgrey,
                              fontSize: HeadingSize,
                              fontWeight: FontWeight.w900)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Order ID : ${model.orderId}",
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton2(
                            title: "Done",
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          AppButton(
                            title: "View Orders",
                            onPressed: () => model.navigateToOrders(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      )
                    ],
                  ),
                ),
              ))
            : (SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Order",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Appgrey,
                              fontWeight: normalBold,
                              fontSize: HeadingSize - 4)),
                      Container(
                        width: 140,
                        height: 2,
                        color: Appgrey,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.request.customData["productName"],
                                style: TextStyle(
                                    color: Appgrey,
                                    fontWeight: normalBold,
                                    fontSize: smallHeading),
                              ),
                              Text(
                                "Description",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Total",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: normalBold,
                                    fontSize: smallHeading),
                              ),
                            ],
                          )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.request.customData["productPrice"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Appgrey,
                                        fontWeight: normalBold,
                                        fontSize: smallHeading),
                                  ),
                                  Text(
                                    "x ${widget.request.customData["productQuantity"]} Ton",
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.request.customData["productTotal"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Appgrey,
                                        fontWeight: normalBold,
                                        fontSize: smallHeading),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("Enter passkey",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Appgrey,
                              fontWeight: normalBold,
                              fontSize: HeadingSize - 4)),
                      Container(
                        width: 150,
                        height: 2,
                        color: Appgrey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              child: Form(
                                key: _formkey,
                                child: PinCodeTextField(
                                  onChanged: (v) {},
                                  onSaved: (v) => model.setPasskey(v),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (v) => model.validatePasskey(v),
                                  showCursor: false,
                                  pinTheme: PinTheme(
                                    activeColor: Appblue,
                                    inactiveColor: Appgrey,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                  ),
                                  keyboardType: TextInputType.number,
                                  appContext: context,
                                  length: 4,
                                ),
                              ),
                            ),
                          ]),
                      model.viewState == ViewState.Busy
                          ? Center(child: (CircularProgressIndicator()))
                          : (Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppButton2(
                                  title: "Cancel",
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                AppButton(
                                  title: "Order",
                                  onPressed: () => model.placeOrder(
                                      _formkey,
                                      widget.request.customData["productId"],
                                      widget.request.customData["productName"],
                                      widget.request.customData["productPrice"],
                                      widget.request
                                          .customData["productQuantity"],
                                      widget.request.customData["productTotal"],
                                      context),
                                )
                              ],
                            ))
                    ],
                  ),
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
              )),
        viewModelBuilder: () => ProductCheckoutBottomSheetViewModel());
  }
}

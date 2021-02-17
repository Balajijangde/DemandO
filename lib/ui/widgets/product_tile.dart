import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/providers/providers.dart';

import 'package:demando/ui/viewmodels/product_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';

import "package:flutter/material.dart";
import 'package:flutter_riverpod/all.dart';
import 'package:stacked/stacked.dart';

class ProductTile extends StatefulWidget {
  final QueryDocumentSnapshot product;
  ProductTile(this.product);

  @override
  _ProductTileState createState() => _ProductTileState(this.product);
}

class _ProductTileState extends State<ProductTile> {
  _ProductTileState(this.product);
  final QueryDocumentSnapshot product;
  int quantity;
  int total;
  bool expand = false;
  String passkey;
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    final currentPrice = product.get("price");
    final previousPrice = product.get("previous price");
    final bool increased = currentPrice > previousPrice ? true : false;
    var difference =
        increased ? currentPrice - previousPrice : previousPrice - currentPrice;
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return ViewModelBuilder<ProductViewModel>.reactive(
        builder: (context, model, child) => Consumer(
              builder: (context, watch, child) {
                final _authStateProvider = watch(authStateProvider);
                return Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 12, right: 12),
                          onTap: () {
                            if (_authStateProvider.data.value != null) {
                              setState(() {
                                expand = !expand;
                              });
                            } else {
                              model.showLoginDialog(context);
                            }
                          },
                          title: Text(product.get("name"),
                              style: TextStyle(
                                  color: Appgrey,
                                  fontWeight: normalBold,
                                  fontSize: smallHeading)),
                          subtitle: Text(
                            "Description",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Column(children: [
                            Text(
                              "$currentPrice",
                              style: TextStyle(
                                  color: Appgrey,
                                  fontSize: smallHeading,
                                  fontWeight: normalBold),
                            ),
                            Text(increased ? "+ $difference" : "- $difference",
                                style: TextStyle(
                                    color:
                                        increased ? Colors.red : Colors.green))
                          ]),
                        ),
                        expand
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: (Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Form(
                                            key: _formkey,
                                            child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (v) =>
                                                    model.validateQuantity(v),
                                                decoration:
                                                    appInputDecorationWithoutIcon(
                                                        labelText: "Quantity"),
                                                onSaved: (value) =>
                                                    model.setProduct(
                                                        product.id,
                                                        product.get('name'),
                                                        int.parse(value),
                                                        product
                                                                .get('price')
                                                                .toDouble() *
                                                            int.parse(value),
                                                        product
                                                            .get('price')
                                                            .toDouble())),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    AppButton(
                                        title: "Place Order",
                                        onPressed: () => model
                                            .showProductCheckoutBottomSheet(
                                                _formkey)
                                        // if (_formkey.currentState.validate()) {
                                        //   _formkey.currentState.save();
                                        //   showDialog(
                                        //       context: context,
                                        //       builder: (BuildContext context) {
                                        //         return StatefulBuilder(
                                        //             builder: (context, setState) {
                                        //           return Dialog(
                                        //             child: Container(
                                        //               height: 200,
                                        //               child: Column(children: [
                                        //                 Text("Enter passkey"),
                                        //                 Expanded(child: TextField(
                                        //                   onChanged: (value) {
                                        //                     setState(() {
                                        //                       passkey = value;
                                        //                     });
                                        //                   },
                                        //                 )),
                                        //                 isBusy
                                        //                     ? (CircularProgressIndicator())
                                        //                     : (ElevatedButton(
                                        //                         onPressed:
                                        //                             () async {
                                        //                           setState(() {
                                        //                             isBusy = true;
                                        //                           });
                                        //                           Database data =
                                        //                               Database();
                                        //                           await data.placeOrder(
                                        //                               FirebaseAuth
                                        //                                   .instance
                                        //                                   .currentUser
                                        //                                   .uid,
                                        //                               product.id,
                                        //                               passkey,
                                        //                               currentPrice,
                                        //                               quantity,
                                        //                               total);
                                        //                           setState(() {
                                        //                             isBusy = false;
                                        //                           });
                                        //                           Navigator.pop(
                                        //                               context);
                                        //                         },
                                        //                         child: Text(
                                        //                             "Place Order")))
                                        //               ]),
                                        //             ),
                                        //           );
                                        //         });
                                        //       });
                                        // }
                                        // },
                                        ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                )),
                              )
                            : (Container())
                      ]),
                    ),
                  ]),
                );
              },
            ),
        viewModelBuilder: () => ProductViewModel());
  }
}

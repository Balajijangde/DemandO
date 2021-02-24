import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demando/AppConstants.dart';
import 'package:demando/providers/providers.dart';
import 'package:demando/ui/viewmodels/product_viewmodel.dart';
import 'package:demando/ui/widgets/app_button.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';

class ProductTile extends StatefulWidget {
  final QueryDocumentSnapshot product;
  ProductTile(this.product);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  int quantity;
  int total;
  String passkey;
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    final currentPrice = widget.product.get("price");
    final previousPrice = widget.product.get("previous price");
    final bool increased = currentPrice > previousPrice ? true : false;
    var difference =
        increased ? currentPrice - previousPrice : previousPrice - currentPrice;
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    return ViewModelBuilder<ProductViewModel>.reactive(
        builder: (context, model, child) => Consumer(
              builder: (context, watch, child) {
                final _authStateProvider = watch(authStateProvider);
                final _connectionProvider = watch(connectivityProvider);
                return Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: model
                            .getProductBackgroundColor(_connectionProvider),
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
                              model.expandTile(_connectionProvider);
                            } else {
                              model.showLoginDialog(context);
                            }
                          },
                          title: Text(widget.product.get("name"),
                              style: TextStyle(
                                  color: Appgrey,
                                  fontWeight: normalBold,
                                  fontSize: smallHeading)),
                          subtitle: Text(
                            //TODO description here
                            "",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: Column(children: [
                            Text(
                              amountFormatter.format(currentPrice),
                              style: TextStyle(
                                  color: Appgrey,
                                  fontSize: smallHeading,
                                  fontWeight: normalBold),
                            ),
                            Text(
                                increased
                                    ? "+ ${amountFormatter.format(difference)}"
                                    : "- ${amountFormatter.format(difference)}",
                                style: TextStyle(
                                    color:
                                        increased ? Colors.red : Colors.green))
                          ]),
                        ),
                        model.expanded
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
                                                        widget.product.id,
                                                        widget.product
                                                            .get('name'),
                                                        int.parse(value),
                                                        widget.product
                                                                .get('price')
                                                                .toDouble() *
                                                            int.parse(value),
                                                        widget.product
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
                                                _formkey)),
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

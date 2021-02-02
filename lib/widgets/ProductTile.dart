import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demando/services/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class ProductTile extends StatefulWidget {
  final QueryDocumentSnapshot product;
  ProductTile(this.product);

  @override
  _ProductTileState createState() => _ProductTileState(this.product);
}

class _ProductTileState extends State<ProductTile> {
  _ProductTileState(this.product);
  final QueryDocumentSnapshot product;
  int quantity = 1;
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
    return Ink(
      child: Column(children: [
        ListTile(
          onTap: () {
            setState(() {
              expand = !expand;
            });
          },

          // showBottomSheet(
          //     elevation: 10.0,
          //     // backgroundColor: Colors.grey,
          //     context: context,
          //     builder: (context) => Container(
          //           child: Column(
          //             children: [
          //               Text(
          //                 product.get("name"),
          //                 style: TextStyle(fontSize: 30.0),
          //               ),
          //               Text("price : $currentPrice"),
          //               Text("total : $total"),
          //               Text("quantity"),
          //               TextField(
          //                 onChanged: (String value) {
          //                   setState(() {
          //                     quantity = int.parse(value);
          //                     total = quantity * currentPrice;
          //                   });
          //                 },
          //               ),
          //               ElevatedButton(
          //                   onPressed: () {
          //                     print(this.quantity);
          //                     print(this.total);
          //                   },
          //                   child: Text("Order"))
          //             ],
          //           ),
          //           width: double.infinity,
          //           height: 200.0,
          //           // )
          //         ));

          title: Text(product.get("name")),
          subtitle: Text(
            "product price ${increased ? 'increased' : 'decreased'} by $difference",
            style: TextStyle(color: increased ? Colors.red : Colors.green),
          ),
          trailing: Text(
            "₹ $currentPrice",
            style: TextStyle(color: Colors.green),
          ),
        ),
        expand
            ? (Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("Total")),
                      Expanded(child: Text(this.total.toString())),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Quantity")),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              quantity = int.parse(value);
                              total = quantity * currentPrice;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    child: Text("Place order"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Dialog(
                                child: Container(
                                  height: 200,
                                  child: Column(children: [
                                    Text("Enter passkey"),
                                    Expanded(child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          passkey = value;
                                        });
                                      },
                                    )),
                                    isBusy
                                        ? (CircularProgressIndicator())
                                        : (ElevatedButton(
                                            onPressed: () async {
                                              setState(() {
                                                isBusy = true;
                                              });
                                              Database data = Database();
                                              await data.placeOrder(
                                                  FirebaseAuth
                                                      .instance.currentUser.uid,
                                                  product.id,
                                                  passkey,
                                                  currentPrice,
                                                  quantity,
                                                  total);
                                              setState(() {
                                                isBusy = false;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("Place Order")))
                                  ]),
                                ),
                              );
                            });
                          });
                    },
                  )
                ],
              ))
            : (Container())
      ]),
    );
  }
}

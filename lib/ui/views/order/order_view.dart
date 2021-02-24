import 'package:demando/AppConstants.dart';
import 'package:demando/providers/providers.dart';
import 'package:demando/ui/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderView extends StatefulWidget {
  OrderView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
    context.read(orderViewModel).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appblue,
        centerTitle: true,
        title: Text(
          "My Orders",
          style: TextStyle(fontWeight: normalBold),
        ),
      ),
      body: Consumer(builder: (context, watch, child) {
        final _model = watch(orderViewModel);
        if (_model.viewState == ViewState.Idle && _model.orders.size == 0) {
          return Center(
            child: Text(
              "No Orders Yet !",
              style: TextStyle(
                  fontSize: HeadingSize,
                  fontWeight: normalBold,
                  color: AppBlack),
            ),
          );
        } else if (_model.viewState == ViewState.Idle &&
            _model.orders.size > 0) {
          return ListView.builder(
              padding: EdgeInsets.only(bottom: 20),
              itemCount: _model.orders.size,
              itemBuilder: (context, int) {
                return OrderTile(
                  productName: _model.orders.docs[int].get("product name"),
                  productPrice: _model.orders.docs[int].get("price"),
                  productQuantity: _model.orders.docs[int].get("quantity"),
                  productTotal: _model.orders.docs[int].get("total"),
                  orderDateTime: DateTime.fromMicrosecondsSinceEpoch(_model
                      .orders.docs[int]
                      .get("datetime")
                      .microsecondsSinceEpoch),
                  orderId: _model.orders.docs[int].id,
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // ListView(
        //   children: [
        //     OrderTile(
        //       productName: "Raipur TMT",
        //       productPrice: 100.00,
        //       productQuantity: 10,
        //       productTotal: 1000.00,
        //       orderDateTime: DateTime.now(),
        //       orderId: "4fDCMR6NJskkIyONAFVn",
        //     )
        //   ],
        // );
      }),
    );
  }
}

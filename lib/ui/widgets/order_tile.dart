import 'package:flutter/material.dart';
import "package:demando/AppConstants.dart";

class OrderTile extends StatelessWidget {
  final String orderId;
  final String productName;
  final DateTime orderDateTime;
  final double productPrice;
  final int productQuantity;
  final double productTotal;
  const OrderTile(
      {Key key,
      this.orderDateTime,
      this.orderId,
      this.productName,
      this.productPrice,
      this.productQuantity,
      this.productTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Id : ${this.orderId}",
            textAlign: TextAlign.left,
            style: TextStyle(color: AppFontGrey),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Time : ${this.orderDateTime.hour} : ${this.orderDateTime.minute} ${this.orderDateTime.hour < 12 ? "AM" : "PM"}, ${getMonth(this.orderDateTime.month).substring(0, 3)} ${this.orderDateTime.day}, ${this.orderDateTime.year}",
            textAlign: TextAlign.right,
            style: TextStyle(color: AppFontGrey),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                this.productName,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppBlack,
                    fontWeight: normalBold,
                    fontSize: smallHeading),
              )),
              Expanded(
                  child: Text(
                amountFormatter.format(this.productPrice),
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: AppBlack,
                    fontWeight: normalBold,
                    fontSize: smallHeading),
              ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                //TODO description here
                "",
                textAlign: TextAlign.left,
                style: TextStyle(color: AppFontGrey),
              )),
              Expanded(
                  child: Text(
                "x ${this.productQuantity} Ton",
                textAlign: TextAlign.right,
                style: TextStyle(color: AppFontGrey),
              ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "Total",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppFontGrey,
                    fontWeight: normalBold,
                    fontSize: smallHeading),
              )),
              Expanded(
                  child: Text(
                amountFormatter.format(this.productTotal),
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: AppBlack,
                    fontWeight: normalBold,
                    fontSize: smallHeading),
              ))
            ],
          ),
        ],
      ),
    );
  }
}

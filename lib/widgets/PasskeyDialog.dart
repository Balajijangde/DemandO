import "package:flutter/material.dart";

class PasskeyDialog extends StatefulWidget {
  @override
  _PasskeyDialogState createState() => _PasskeyDialogState();
}

class _PasskeyDialogState extends State<PasskeyDialog> {
  String passkey;
  bool isBusy = false;
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    setState(() {
                      isBusy = true;
                    });
                    Future.delayed(Duration(seconds: 5));
                    setState(() {
                      isBusy = false;
                    });
                  },
                  child: Text("Place Order")))
        ]),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {

  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _TransferPageState();

}

class _TransferPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {

    return (
      Scaffold(
        appBar: AppBar(
          title: Text(
            'Оплата'
          )
        ),
        body: Column(
          children: [

          ]
        )
      )
    );
  }
}
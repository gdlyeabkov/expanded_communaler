import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

class PromoCodePage extends StatefulWidget {

  const PromoCodePage({Key? key}) : super(key: key);

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();

}

class _PromoCodePageState extends State<PromoCodePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Промокод'
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              TextField(
                onChanged: (value) {

                },
                decoration: new InputDecoration.collapsed(
                  hintText: '',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0
                    )
                  )
                )
              ),
              TextButton(
                child: Icon(
                  Icons.arrow_circle_right
                ),
                onPressed: () {

                }
              )
            ]
          )
        ],
      ),
    );
  }
}
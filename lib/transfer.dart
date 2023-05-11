import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';
import 'models.dart';

class TransferPage extends StatefulWidget {

  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();

}

class _TransferPageState extends State<TransferPage> {

  bool isFlashLightEnabled = false;
  late DatabaseHandler handler;
  int? amountId = 0;
  int userId = 0;
  Amount currentAmount = Amount(
    provider: '',
    number: '',
    email: 0,
    cost: 0,
    id: 0,
    status: '',
    user: 0,
    datetime: ''
  );

  @override
  initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {
        handler.retrieveAmounts().then((value) {
          for (Amount amount in value) {
            int currentAmountId = amount.id!;
            bool isMyAmount = currentAmountId == amountId;
            if (isMyAmount) {
              currentAmount = amount;
              break;
            }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      if (arguments != null) {
        print(arguments['amountId']);
        amountId = arguments['amountId'];
        userId = arguments['userId'];
      }
    });

    return (
      Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 15
                ),
                child: Icon(
                  Icons.circle
                )
              ),
              Text(
                currentAmount.number,
                style: TextStyle(
                  fontSize: 14
                )
              )
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
              },
              child: Icon(
                Icons.flashlight_on,
                color: Color.fromARGB(100, 255, 255, 255),
              )
            )
          ]
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 200, 200, 200)
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(
                        MediaQuery.of(context).size.width,
                        45.0
                      )
                    )
                  ),
                  child: Text(
                    'Передать показания'
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/area',
                      arguments: {
                        'userId': userId
                      }
                    );
                  }
                )
              ]
            )
          )
        )
      )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';
import 'models.dart';

class PaymentPage extends StatefulWidget {

  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _TransferPageState();

}

class _TransferPageState extends State<PaymentPage> {

  String cost = '';
  bool agreement = false;
  bool insurance = true;
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

  payAmount(context) {
    int paymentCost = int.parse(cost);
    int updatedCost = currentAmount.cost + paymentCost;
    handler.updateAmountCost(amountId!, updatedCost);
    // Navigator.pushNamed(context, '/area');
    Navigator.pushNamed(
      context,
      '/area',
      arguments: {
        'userId': userId
      }
    );
  }

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
            ]
          )
        ),
        body: Column(
          children: [
            Text(
              '???????????? ????????????????????'
            ),
            Text(
              '?????????? ?? ????????????'
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  cost = value;
                });
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
            Text(
              '???????????????? ???????????? ????????????'
            ),
            Row(
              children: [
                Icon(
                  Icons.payment
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15
                  ),
                  child: Text(
                    'Google Pay',
                    style: TextStyle(
                      color: Color.fromARGB(255, 215, 215, 215),
                      fontWeight: FontWeight.bold
                    )
                  )
                )
              ]
            ),
            Divider(
              thickness: 1.0
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.payment
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 15
                      ),
                      child: Text(
                        '???????????????????? ????????????',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 150),
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  ]
                ),
                Icon(
                  Icons.check
                )
              ]
            ),
            Divider(
              thickness: 1.0
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '???????????????????????? ??????????????????????: 95,00 ??????.',
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
                Switch(
                  value: insurance,
                  onChanged: (value) {

                  }
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '?? ???????????????? ?? ?????????????????? ????????????',
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
                Switch(
                  value: agreement,
                  onChanged: (value) {

                  }
                ),
              ]
            ),
            TextButton(
              child: Text(
                '??????????????????'
              ),
              onPressed: () {

              }
            ),
            Text(
              '?? ???????????? ??????????????????????'
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.payment,
                  size: 36
                ),
                Icon(
                  Icons.payment,
                  size: 36
                ),
                Icon(
                  Icons.payment,
                  size: 36
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(
                vertical: 15
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 200, 200, 255)
              ),
              child: Column(
                children: [
                  Text(
                    '???????????? 1% ?????? ???????????? ????????????',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '???????????????????????????????? ?????????? ???????? ?????? ?? ??????????????????\n???????????????????? ?????? ?????????????????? ????????\n???? ????????????????????\n???????????? ?? ?????????????????? ????????????\n?????????? ?????????????? ??????????????.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 150, 150, 150)
                        )
                      ),
                      Icon(
                        Icons.chevron_right
                      )
                    ]
                  ),
                  Text(
                    '??????????????????',
                    style: TextStyle(
                      color: Color.fromARGB(255, 150, 150, 255)
                    )
                  ),
                ]
              )
            ),
            TextButton(
              child: Text(
                '????????????????'
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.orange
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(
                    MediaQuery.of(context).size.width - 30,
                    45.0
                  )
                )
              ),
              onPressed: () {
                payAmount(context);
              }
            )
          ]
        )
      )
    );
  }
}
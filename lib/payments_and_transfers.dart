import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentsAndTransfersPage extends StatefulWidget {

  const PaymentsAndTransfersPage({Key? key}) : super(key: key);

  @override
  State<PaymentsAndTransfersPage> createState() => _PaymentsAndTransfersPageState();

}

class _PaymentsAndTransfersPageState extends State<PaymentsAndTransfersPage> {
  @override
  Widget build(BuildContext context) {

    return (
      Scaffold(
        appBar: AppBar(
          title: Text(
            'Платежи и переводы'
          )
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.phone_android,
                        size: 48,
                      ),
                      Text(
                        'Мобильная связь',
                        style: TextStyle(
                          color: Colors.orange
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  onTap: () {

                  }
                ),
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.wifi,
                        size: 48,
                      ),
                      Text(
                        'Интернет, ТВ и\nТелефония',
                        style: TextStyle(
                            color: Colors.orange
                        )
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  onTap: () {

                  }
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.house,
                        size: 48,
                      ),
                      Text(
                        'Коммунальные платежи',
                        style: TextStyle(
                          color: Colors.orange
                        )
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  onTap: () {

                  }
                ),
                Column(
                  children: [
                    Icon(
                      Icons.phone_android,
                      size: 48,
                      color: Colors.transparent
                    ),
                    Text(
                      'связь',
                      style: TextStyle(
                        color: Colors.transparent
                      )
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                )
              ]
            ),
          ]
        )
      )
    );
  }
}

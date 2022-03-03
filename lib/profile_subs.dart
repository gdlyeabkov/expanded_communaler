import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

import 'db.dart';
import 'models.dart';

class ProfileSubsPage extends StatefulWidget {

  const ProfileSubsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSubsPage> createState() => _ProfileSubsPageState();
}

class _ProfileSubsPageState extends State<ProfileSubsPage> {

  late DatabaseHandler handler;

  @override
  initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Подписки'
        )
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Рекламно-информационная рассылка'
              ),
              Icon(
                Icons.chevron_right
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Рассылка счетов ООО \"МосОблЕИРЦ\"'
              ),
              Icon(
                Icons.chevron_right
              )
            ]
          )
        ]
      )
    );
  }
}
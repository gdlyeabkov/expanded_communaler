import 'dart:math';

import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

import 'db.dart';

class AddAmountPage extends StatefulWidget {

  const AddAmountPage({Key? key}) : super(key: key);

  @override
  State<AddAmountPage> createState() => _AddAmountPageState();
}

class _AddAmountPageState extends State<AddAmountPage> {

  late DatabaseHandler handler;
  String provider = 'Поставщик';
  String number = '';
  String status = 'Статус отношения к ЛС';
  bool email = true;
  int userId = 0;
  List<String> providers = [
    'Поставщик',
    'АО Мосэнергосбыт',
    'АО МосОблЕИРЦ',
    'АО Мосэнергосбыт + ТКО',
  ];
  List<String> statuses = [
    'Статус отношения к ЛС',
    'Собственник',
    'Другое',
    'Наниматель',
    'Зарегестрированный',
    'Проживает',
  ];

  addAmount(context) {
    int providerFieldLength = provider.length;
    bool isProviderFieldFilled = providerFieldLength >= 1;
    int numberFieldLength = number.length;
    bool isNumberFieldFilled = numberFieldLength >= 1;
    int statusFieldLength = status.length;
    bool isStatusFieldFilled = statusFieldLength >= 1;
    bool isFieldsFilled = isProviderFieldFilled || isNumberFieldFilled || isStatusFieldFilled;
    if (isFieldsFilled) {
      int rawEmail = email ? 1 : 0;
      DateTime dateTime = DateTime.now();
      int dateTimeHours = dateTime.hour;
      int dateTimeMinutes = dateTime.minute;
      int dateTimeDay = dateTime.day;
      int dateTimeMonth = dateTime.month;
      int dateTimeYear = dateTime.year;
      String rawDateTimeDay = dateTimeDay.toString();
      int rawDateTimeDayLength = rawDateTimeDay.length;
      bool isAddDayPrefix = rawDateTimeDayLength == 1;
      if (isAddDayPrefix) {
        rawDateTimeDay = '0${rawDateTimeDay}';
      }
      String rawDateTimeMonth = dateTimeMonth.toString();
      int rawDateTimeMonthLength = rawDateTimeMonth.length;
      bool isAddMonthPrefix = rawDateTimeMonthLength == 1;
      if (isAddMonthPrefix) {
        rawDateTimeMonth = '0${rawDateTimeMonth}';
      }
      String rawDateTimeHours = dateTimeHours.toString();
      int rawDateTimeHoursLength = rawDateTimeHours.length;
      bool isAddHoursPrefix = rawDateTimeHoursLength == 1;
      if (isAddHoursPrefix) {
        rawDateTimeHours = '0${rawDateTimeHours}';
      }
      String rawDateTimeMinutes = dateTimeMinutes.toString();
      int rawDateTimeMinutesLength = rawDateTimeMinutes.length;
      bool isAddMinutesPrefix = rawDateTimeMinutesLength == 1;
      if (isAddMinutesPrefix) {
        rawDateTimeMinutes = '0${rawDateTimeMinutes}';
      }
      String rawDateTime = '${rawDateTimeDay}.${rawDateTimeMonth}.${dateTimeYear}T${rawDateTimeHours}:${rawDateTimeMinutes}';
      int cost = new Random().nextInt(5000);
      handler.addNewAmounts(provider, number, status, rawEmail, rawDateTime, cost, userId);
      // Navigator.pushNamed(context, '/area');
      Navigator.pushNamed(
        context,
        '/area',
        arguments: {
          'userId': userId
        }
      );
    } else {
      String msg = '';
      bool isProviderFieldNotFilled = !isProviderFieldFilled;
      if (isProviderFieldNotFilled) {
        msg += 'Поле \"Поставщик\" не заполнено\n';
      }
      bool isNumberFieldNotFilled = !isNumberFieldFilled;
      if (isNumberFieldNotFilled) {
        msg += 'Поле \"Номер лицевого счета\" не заполнено\n';
      }
      bool isStatusFieldNotFilled = !isStatusFieldFilled;
      if (isStatusFieldNotFilled) {
        msg += 'Поле \"Статус отношения к ЛС\" не заполнено\n';
      }
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Сообщение'),
            content: Container(
              child: Column(
                children: [
                  Text(
                    msg
                  )
                ]
              )
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  return Navigator.pop(context, 'OK');
                },
                child: const Text('ОК')
              )
            ]
          )
      );
    }
  }

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

    setState(() {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map;
      if (arguments != null) {
        print(arguments['userId']);
        userId = arguments['userId'];
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Добавление лицевого счета'
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: provider,
            icon: const Icon(
                Icons.arrow_drop_down
            ),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                provider = newValue!;
              });
            },
            items: providers.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                number = value;
              });
            },
            decoration: new InputDecoration.collapsed(
              hintText: 'Номер лицевого счета',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0
                )
              )
            )
          ),
          DropdownButton<String>(
            value: status,
            icon: const Icon(
                Icons.arrow_drop_down
            ),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                status = newValue!;
              });
            },
            items: statuses.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Получать счета по email'
              ),
              Switch(
                value: email,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                }
              )
            ]
          ),
          TextButton(
            child: Text(
              'Добавить лицевой счет'
            ),
            onPressed: () {
              addAmount(context);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.orange
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                Size(
                  MediaQuery.of(context).size.width,
                  45.0
                )
              )
            )
          )
        ],
      ),
    );
  }
}
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';

import 'db.dart';
import 'models.dart';

class PersonalAreaPage extends StatefulWidget {

  const PersonalAreaPage({Key? key}) : super(key: key);

  @override
  State<PersonalAreaPage> createState() => _PersonalAreaPageState();

}

class _PersonalAreaPageState extends State<PersonalAreaPage> {

  int currentTab = 0;
  String currentTabTitle = '';
  List currentTabTitles = [
    '',
    'Услуги',
    'Вопросы',
    '',
    'Еще'
  ];
  List<Widget> amounts = [

  ];
  late DatabaseHandler handler;
  int userId = 0;
  Amount currentAmount = Amount(
    provider: '',
    status: '',
    user: 0,
    number: '',
    email: 0,
    cost: 0,
    datetime: '',
  );
  List<Widget> messages = [

  ];
  String message = '';
  late TextField messageInputField;

  addAmount(Amount record, context) {
    int amountId = record.id!;
    int amountUserId = record.user;
    bool isMyAmount = userId == amountUserId;
    if (isMyAmount) {
      String amountNumber = record.number;
      int amountIndex = amounts.length;

      Widget amount = GestureDetector(
        onTap: () {
          setState(() {
            currentAmount = record;
          });
        },
        child: Container(
          height: 25,
          margin: EdgeInsets.symmetric(
            horizontal: 10
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 3
          ),
          decoration: BoxDecoration(
            color: (
              amountId == currentAmount.id ?
                Color.fromARGB(255, 225, 225, 225)
              :
                Color.fromARGB(255, 185, 185, 185)
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)
            )
          ),
          child: Text(
            amountNumber
          )
        )
      );
      amounts.add(amount);
      // setState(() {
      //   currentAmount = record;
      // });
    }
  }

  sendMessage() {
    Widget msg = Container(
      padding: EdgeInsets.all(
        15
      ),
      margin: EdgeInsets.all(
        15
      ),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      width: 300,
      height: 75,
      child: Text(
        message
      )
    );
    setState(() {
      messages.add(msg);
      // message = '';
    });
  }

  @override
  initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {
        messageInputField = TextField(

          onChanged: (value) {
            setState(() {
              message = value;
            });
          },
          decoration: new InputDecoration.collapsed(
              hintText: 'Сообщение',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.0
              )
            )
          )
        );
        int chance = new Random().nextInt(2);
        bool isPinOffer = chance == 1;
        if (isPinOffer) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(''),
              content: Container(
                child: Column(
                  children: [
                    Text(
                      'Увеличьте безопасность учетной\nзаписи и скорость работы\nс приложением используя\nраспознавние отпечатка пальца\nили PIN-код.'
                    )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    return Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('НЕТ')
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                    // return Navigator.pop(context, 'OK');
                  },
                  child: const Text('ДА')
                ),
              ]
            )
          );
        }
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

    return DefaultTabController(
        initialIndex: 0,
        length: 6,
        child: Scaffold(
          appBar:
          (
            (currentTab == 1 || currentTab == 2 || currentTab == 4) ?
              AppBar(
                title: Text(
                  currentTabTitle
                ),
                actions: [
                  (
                    currentTab == 1 ?
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/promocode');
                        },
                        child: Icon(
                          Icons.percent_outlined
                        )
                      )
                    :
                      Column()
                  )
                ]
              )
            :
              null
          ),
          persistentFooterButtons: [
            Container(
              child: TabBar(
                onTap: (index) {
                  print('currentTabIndex: ${index}');
                  setState(() {
                    currentTab = index;
                    currentTabTitle = currentTabTitles[currentTab];
                  });
                },
                tabs: <Widget>[
                  Tab(
                      text: 'Главная'
                  ),
                  Tab(
                      text: 'Услуги'
                  ),
                  Tab(
                      text: 'Вопросы'
                  ),
                  Tab(
                      text: 'Чат'
                  ),
                  Tab(
                      text: 'Еще'
                  ),
                  Tab(
                    text: 'Database inspector'
                  )
                ]
              ),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            )
          ],
          body: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child:  Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, '/amount/add');
                              Navigator.pushNamed(
                                context,
                                '/amount/add',
                                arguments: {
                                  'userId': userId
                                }
                              );
                            },
                            child: Container(
                              height: 25,
                              margin: EdgeInsets.symmetric(
                                horizontal: 10
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 3
                              ),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 185, 185, 185),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)
                                )
                              ),
                              child: Icon(
                                Icons.add
                              )
                            )
                          ),
                          FutureBuilder(
                            future: handler.retrieveAmounts(),
                            builder: (BuildContext context, AsyncSnapshot<List<Amount>> snapshot) {
                              int snapshotsCount = 0;
                              if (snapshot.data != null) {
                                snapshotsCount = snapshot.data!.length;
                                amounts = [];
                                for (int snapshotIndex = 0; snapshotIndex < snapshotsCount; snapshotIndex++) {
                                  addAmount(snapshot.data!.elementAt(snapshotIndex), context);
                                }
                              }
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 250,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: amounts
                                        )
                                      )
                                    )
                                  ]
                                );
                              } else {
                                return Row(

                                );
                              }
                              return Row(

                              );
                            },
                          )
                        ]
                      ),
                      margin: EdgeInsets.all(35)
                    )
                  ),
                    (
                      amounts.length <= 0 ?
                        Text(
                          'Вы не прикрепили еще ни одного счета'
                        )
                      :
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Адресс проживания'
                                ),
                                Icon(
                                  Icons.info
                                )
                              ]
                            ),
                            Text(
                              currentAmount.cost < 0 ?
                                'Сумма к оплате'
                              :
                                'Переплата'
                            ),
                            Text(
                              '${currentAmount.cost} Р',
                              style: TextStyle(
                                fontSize: 36,
                                color: (
                                  currentAmount.cost >= 0 ?
                                    Color.fromARGB(255, 0, 150, 0)
                                  :
                                    Color.fromARGB(255, 255, 0, 0)
                                )
                              )
                            ),
                            TextButton(
                              child: Text(
                                'Еще'
                              ),
                              onPressed: () {

                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 225, 225, 225)
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)
                                  )
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(
                                    125.0,
                                    45.0
                                  )
                                ),
                                foregroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 0, 0, 0)
                                )
                              )
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)
                                  )
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(
                                    275.0,
                                    45.0
                                  )
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning
                                  ),
                                  Text(
                                    'Важные уведомления'
                                  )
                                ]
                              ),
                              onPressed: () {

                              }
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.credit_card_rounded,
                                          size: 48
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle
                                        )
                                      ),
                                      Text(
                                        'Оплатить\nбез',
                                        textAlign: TextAlign.center,
                                      )
                                    ]
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/payment');
                                    // int currentAmountId = currentAmount.id!;
                                    Navigator.pushNamed(
                                      context,
                                      '/payment',
                                      arguments: {
                                        'userId': userId,
                                        'amountId': currentAmount.id
                                      }
                                    );
                                  },
                                ),
                                VerticalDivider(
                                  thickness: 1.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/transfer');
                                    Navigator.pushNamed(
                                      context,
                                      '/transfer',
                                      arguments: {
                                        'userId': userId,
                                        'amountId': currentAmount.id
                                      }
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.inbox,
                                          size: 48
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle
                                        )
                                      ),
                                      Text(
                                        'Передать\nпоказания',
                                        textAlign: TextAlign.center,
                                      )
                                    ]
                                  )
                                )
                              ],
                            )
                        ]
                      )
                  )
                ]
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(
                          text: 'Каталог'
                        ),
                        Tab(
                          text: 'Заказанные'
                        )
                      ],
                    ),
                    TabBarView(
                      children: [
                        Column(
                          children: [
                            Text(
                              'a'
                            )
                          ]
                        ),
                        Column(
                          children: [
                            Text(
                              'b'
                            )
                          ]
                        )
                      ]
                    )
                  ]
                )
              ),
              DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(
                            text: 'Задать вопрос'
                        ),
                        Tab(
                          text: 'История'
                        )
                      ],
                    ),
                    TabBarView(
                      children: [
                        Column(
                          children: [
                            Text(
                              'a'
                            )
                          ]
                        ),
                        Column(
                          children: [
                            Text(
                              'b'
                            )
                          ]
                        )
                      ]
                    )
                  ]
                )
              ),
              Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 350,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(
                              15
                            ),
                            margin: EdgeInsets.all(
                              15
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            width: 300,
                            height: 75,
                            child: Text(
                              'Здраствуйте! Введите свое обращение,\nпожалуйста.'
                            )
                          ),
                          ...messages
                        ]
                      )
                    )
                  ),
                  messageInputField,
                  TextButton(
                    child: Icon(
                        Icons.send
                    ),
                    onPressed: () {
                      sendMessage();
                    }
                  )
                ]
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/profile');
                      Navigator.pushNamed(
                        context,
                        '/profile',
                        arguments: {
                          'userId': userId
                        }
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle
                            ),
                            Container(
                              child: Text(
                                'Профиль'
                              ),
                              margin: EdgeInsets.only(
                                left: 15
                              )
                            )
                          ]
                        ),
                        Icon(
                          Icons.chevron_right
                        )
                      ]
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/contacts');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on
                            ),
                            Container(
                              child: Text(
                                'Контакты'
                              ),
                              margin: EdgeInsets.only(
                                left: 15
                              )
                            )
                          ]
                        ),
                        Icon(
                          Icons.chevron_right
                        )
                      ]
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/payments_and_transfers');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info
                            ),
                            Container(
                              child: Text(
                                'Платежи и переводы'
                              ),
                              margin: EdgeInsets.only(
                                left: 15
                              )
                            )
                          ]
                        ),
                        Icon(
                          Icons.chevron_right
                        )
                      ]
                    )
                  ),
                ]
              ),
              TextButton(
                child: Text(
                  'Database Inspector'
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DatabaseList()));
                }
              )
            ]
          )
      )
    );
  }
}

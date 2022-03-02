import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        initialIndex: 0,
        length: 5,
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
                        'Сумма к оплате'
                      ),
                      Text(
                        '1000 Р',
                        style: TextStyle(
                          fontSize: 36,
                          color: (
                            true ?
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
                              Navigator.pushNamed(context, '/payment');
                            },
                          ),
                          VerticalDivider(
                            thickness: 1.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/transfer');
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
                          )
                        ]
                      )
                    )
                  ),
                  Row(
                    children: [
                      TextField(
                        onChanged: (value) {

                        },
                        decoration: new InputDecoration.collapsed(
                          hintText: 'Сообщение',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.0
                            )
                          )
                        )
                      ),
                      TextButton(
                        child: Icon(
                          Icons.send
                        ),
                        onPressed: () {

                        }
                      )
                    ]
                  )
                ]
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
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
              )
            ]
          )
      )
    );
  }
}

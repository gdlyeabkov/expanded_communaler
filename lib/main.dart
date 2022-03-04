import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/db.dart';
import 'package:receipts/payment.dart';
import 'package:receipts/payments_and_transfers.dart';
import 'package:receipts/personalarea.dart';
import 'package:receipts/profile.dart';
import 'package:receipts/profile_accounts.dart';
import 'package:receipts/profile_contacts.dart';
import 'package:receipts/profile_data.dart';
import 'package:receipts/profile_password.dart';
import 'package:receipts/profile_security.dart';
import 'package:receipts/profile_subs.dart';
import 'package:receipts/promocode.dart';
import 'package:receipts/register.dart';
import 'package:receipts/transfer.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'add_amount.dart';
import 'models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Softtrack коммунальные услуги',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Softtrack коммунальные услуги'),
      routes: {
        '/main': (context) => MyHomePage(title: 'title'),
        '/contacts': (context) => ContactsPage(),
        '/area': (context) => PersonalAreaPage(),
        '/register': (context) => RegisterPage(),
        '/promocode': (context) => PromoCodePage(),
        '/profile': (context) => ProfilePage(),
        '/payments_and_transfers': (context) => PaymentsAndTransfersPage(),
        '/transfer': (context) => TransferPage(),
        '/payment': (context) => PaymentPage(),
        '/amount/add': (context) => AddAmountPage(),
        '/profile/subs': (context) => ProfileSubsPage(),
        '/profile/accounts': (context) => ProfileAccountsPage(),
        '/profile/data': (context) => ProfileDataPage(),
        '/profile/password': (context) => ProfilePasswordPage(),
        '/profile/contacts': (context) => ProfileContactsPage(),
        '/profile/security': (context) => ProfileSecurityPage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late DatabaseHandler handler;
  String login = '';
  String password = '';

  loginUser(context) async {
    await handler.retrieveUsers().then((value) {
      bool isUserNotFound = true;
      int detectedUserId = 0;
      for (User user in value) {
        int userId = user.id!;
        String userLogin = user.login;
        String userPassword = user.password;
        print('userLogin: ${userLogin}');
        print('userPassword: ${userPassword}');
        print('login: ${login}');
        print('password: ${password}');
        bool isLoginsMatches = userLogin == login;
        bool isPasswordsMatches = userPassword == password;
        print('isLoginsMatches: ${isLoginsMatches}');
        print('isPasswordsMatches: ${isPasswordsMatches}');
        bool isDetectUser = isPasswordsMatches && isLoginsMatches;
        if (isDetectUser) {
          isUserNotFound = false;
          detectedUserId = userId;
          break;
        }
      }
      if (isUserNotFound) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Сообщение'),
            content: Container(
              child: Column(
                children: [
                  Text(
                    'Неправильно введен логин или пароль'
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
      } else {
        Navigator.pushNamed(
          context,
          '/area',
          arguments: {
            'userId': detectedUserId
          }
        );
        // Navigator.pushNamed(context, '/area');
      }
      // Navigator.pushNamed(context, '/area');
    });
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Добро пожаловать',
            style: TextStyle(
              fontSize: 32
            )
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                login = value;
              });
            },
            decoration: new InputDecoration.collapsed(
              hintText: 'E-mail',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0
                )
              )
            )
          ),
          TextField(
            obscureText: true,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            decoration: new InputDecoration.collapsed(
              hintText: 'Пароль',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0
                )
              )
            )
          ),
          Text(
            'Забыли пароль'
          ),
          TextButton(
            child: Text(
              'Войти'
            ),
            onPressed: () {
              loginUser(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.orange
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                Size(
                  MediaQuery.of(context).size.width,
                  45.0
                )
              )
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '---------------------'
              ),
              Text(
                'или'
              ),
              Text(
                '---------------------'
              )
            ]
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.red,
                    width: 2.0
                  )
                )
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                Size(
                  MediaQuery.of(context).size.width,
                  45.0
                )
              ),
              foregroundColor: MaterialStateProperty.all<Color>(
                Colors.red
              )
            ),
            child: Text(
              'Войти через'
            ),
            onPressed: () {

            }
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'У вас еще нет аккаунта'
              ),
              TextButton(
                child: Text(
                  'Зарегестрируйтесь',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                }
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on
                    ),
                    Text(
                      'Контакты',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 255)
                      )
                    )
                  ]
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/contacts');
                }
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      Icons.help
                    ),
                    Text(
                      'Техподдержка',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 255)
                      ),
                    )
                  ]
                ),
                onTap: () async {
                  final Email email = Email(
                    body: '<br>---Пожалуйста, не удаляйте эту информацию---<br><br>Операционная система: 11<br>Сервисы Google-Play: 220221037<br>Устройство: samsung SM-A207F<br>Приложение: версия 1.28.1GMS (1139)<br>Тип соединения: WI-FI connection<br>Язык: русский<br>Страна: Россия<br>Часовой пояс: Москва, стандартное время<br>Геолокация: Выключено<br>Push сообщения: Включено<br>Идентификатор Push FB: dkZhRL2zlRI:APA91bEOM39rEDCqf4oOh_vbf95d14vkL4WkQQGbbMqMCJE__a6QG4J3Ebri-Jh2naqUtqS5aY-vJ3PJQ202k1o3SHcdiI9dloHpO-ELWhoprg6oGtRx8qU6fDuYwCFG1N8OJBJuwGM3',
                    subject: 'Обратная связь',
                    recipients: ['LKK_INFO@mosenergosbyt.ru']
                  );
                  await FlutterEmailSender.send(email);
                }
              )
            ]
          ),
          TextButton(
            child: Text(
              'Официальные сайты'
            ),
            onPressed: () {
              showModalBottomSheet<String>(
                context: context,
                builder: (BuildContext context) => BottomSheet(
                  onClosing: () {

                  },
                  builder: (context) {
                    return Container(
                      child: Column(
                        children: [
                          Text(
                            'Официальные сайты',
                            style: TextStyle(
                              fontWeight: FontWeight.w900
                            )
                          ),
                          Text(
                            'Нажмите чтобы перейти на сайт'
                          ),
                          GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 25
                                      ),
                                      child: Text(
                                        'АО \"Мосэенргосбыт\"',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 200, 200, 200)
                                        )
                                      )
                                    )
                                  ]
                                )
                              ]
                            ),
                            onTap: () async {
                              final String url = 'https://google.com';
                              if (await UrlLauncher.canLaunch(url))
                                UrlLauncher.launch(url);
                            }
                          ),
                          Divider(
                            thickness: 1.0,
                          ),
                          GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 25
                                      ),
                                      child: Text(
                                        'ООО \"МосОблЕИРЦ\"',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 200, 200, 200)
                                        )
                                      )
                                    )
                                  ]
                                )
                              ]
                            ),
                            onTap: () async {
                              final String url = 'https://google.com';
                              if (await UrlLauncher.canLaunch(url))
                                UrlLauncher.launch(url);
                            }
                          )
                        ]
                      ),
                      padding: EdgeInsets.all(
                        15
                      )
                    );
                  }
                )
              );
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 0, 0, 255)
              )
            )
          )
        ],
      ),
    );
  }
}

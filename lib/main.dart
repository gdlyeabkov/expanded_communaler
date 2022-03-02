import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/payment.dart';
import 'package:receipts/payments_and_transfers.dart';
import 'package:receipts/personalarea.dart';
import 'package:receipts/profile.dart';
import 'package:receipts/promocode.dart';
import 'package:receipts/register.dart';
import 'package:receipts/transfer.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onChanged: (value) {

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
              Navigator.pushNamed(context, '/area');
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
              Row(
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
              )
            ]
          ),
          Text(
            'Официальные сайты',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 255)
            )
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                Text(
                    'Зарегестрируйтесь',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 255)
                    )
                ),
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
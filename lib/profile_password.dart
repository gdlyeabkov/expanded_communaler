import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

import 'db.dart';
import 'models.dart';

class ProfilePasswordPage extends StatefulWidget {

  const ProfilePasswordPage({Key? key}) : super(key: key);

  @override
  State<ProfilePasswordPage> createState() => _ProfilePasswordPageState();
}

class _ProfilePasswordPageState extends State<ProfilePasswordPage> {

  late DatabaseHandler handler;
  String login = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  bool email = false;

  addUser(context) {
    bool isPasswordsMatches = password == confirmPassword;
    int loginFieldLength = login.length;
    bool isLoginFieldFilled = loginFieldLength >= 1;
    int phoneFieldLength = phone.length;
    bool isPhoneFieldFilled = phoneFieldLength >= 1;
    int passwordFieldLength = password.length;
    bool isPasswordFieldFilled = passwordFieldLength >= 1;
    int confirmPasswordFieldLength = confirmPassword.length;
    bool isConfirmPasswordFieldFilled = confirmPasswordFieldLength >= 1;
    int nameFieldLength = name.length;
    bool isNameFieldFilled = nameFieldLength >= 1;
    bool isFieldsFilled = isLoginFieldFilled || isPhoneFieldFilled || isPasswordFieldFilled || isConfirmPasswordFieldFilled || isNameFieldFilled;
    bool isCanLogin = isPasswordsMatches && isFieldsFilled;
    if (isCanLogin) {
      int rawEmail = email ? 1 : 0;
      handler.addNewUsers(login, password, '', phone, name, rawEmail, '', '', '', '', '');
      handler.retrieveUsers().then((value) {
        User currentUser = value.last;
        int userId = currentUser.id!;
        // Navigator.pushNamed(context, '/area');
        Navigator.pushNamed(
            context,
            '/area',
            arguments: {
              'userId': userId
            }
        );
      });
    } else {
      String msg = '';
      bool isLoginFieldNotFilled = !isLoginFieldFilled;
      if (isLoginFieldNotFilled) {
        msg += 'Поле \"E-mail\" не заполнено\n';
      }
      bool isPhoneFieldNotFilled = !isPhoneFieldFilled;
      if (isPhoneFieldNotFilled) {
        msg += 'Поле \"Номер телефона\" не заполнено\n';
      }
      bool isPasswordFieldNotFilled = !isPasswordFieldFilled;
      if (isPasswordFieldNotFilled) {
        msg += 'Поле \"Придумайте пароль\" не заполнено\n';
      }
      bool isConfirmPasswordFieldNotFilled = !isConfirmPasswordFieldFilled;
      if (isConfirmPasswordFieldNotFilled) {
        msg += 'Поле \"Повторите пароль\" не заполнено\n';
      }
      bool isNameFieldNotFilled = !isNameFieldFilled;
      if (isNameFieldNotFilled) {
        msg += 'Поле \"Имя пользователя\" не заполнено\n';
      }
      bool isPasswordsNotMatches = !isPasswordsMatches;
      if (isPasswordsNotMatches) {
        msg += 'Поля \"Придумайте пароль\" и \"Повторите пароль\" не совпадают';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Изменить пароль'
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
              decoration: new InputDecoration.collapsed(
                  hintText: 'Мобильный телефон',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0
                      )
                  )
              )
          ),
          TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: new InputDecoration.collapsed(
                  hintText: 'Придумайте пароль',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0
                      )
                  )
              ),
              obscureText: true
          ),
          TextField(
              onChanged: (value) {
                setState(() {
                  confirmPassword = value;
                });
              },
              decoration: new InputDecoration.collapsed(
                  hintText: 'Повторите пароль',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0
                      )
                  )
              ),
              obscureText: true
          ),
          TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: new InputDecoration.collapsed(
                  hintText: 'Имя пользователя',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0
                      )
                  )
              )
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    children: [
                      Text(
                          'Даю согласие на получение рвссылок\nрекламно-информационного характера'
                      ),
                      Text(
                          'Без согласия на рекламу Вы упускаете\nнаши выгодные предложения'
                      )
                    ]
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
          Text(
              'Нажимая кнопку \"Далее\" Вы принимаете\nПользовательское соглашение и даете\nна обработку персональных данных'
          ),
          TextButton(
              child: Text(
                  'Далее'
              ),
              onPressed: () {
                addUser(context);
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.orange
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(
                          45.0,
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
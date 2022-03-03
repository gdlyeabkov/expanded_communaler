import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

import 'db.dart';
import 'models.dart';

class ProfileSecurityPage extends StatefulWidget {

  const ProfileSecurityPage({Key? key}) : super(key: key);

  @override
  State<ProfileSecurityPage> createState() => _ProfileSecurityPageState();
}

class _ProfileSecurityPageState extends State<ProfileSecurityPage> {

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
          'Безопасность'
        )
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Использование PIN-кода',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 175),
              fontWeight: FontWeight.w500
            )
          ),
          Divider(
            thickness: 1.0
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Вход по PIN-коду',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0)
                )
              ),
              Switch(
                value: false,
                onChanged: (value) {

                }
              )
            ]
          ),
          Divider(
              thickness: 1.0
          ),
          Text(
            'При входе в приложение потребуется ввести код\nдля подтверждения доступа',
            style: TextStyle(
              color: Color.fromARGB(255, 175, 175, 175),
              fontWeight: FontWeight.w500
            )
          ),
          Divider(
            thickness: 1.0
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Изменить код-пароль',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0)
                )
              ),
              Icon(
                Icons.chevron_right
              )
            ]
          ),
          Divider(
            thickness: 1.0
          )
        ]
      )
    );
  }
}
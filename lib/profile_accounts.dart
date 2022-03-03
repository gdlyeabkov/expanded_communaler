import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

import 'db.dart';
import 'models.dart';

class ProfileAccountsPage extends StatefulWidget {

  const ProfileAccountsPage({Key? key}) : super(key: key);

  @override
  State<ProfileAccountsPage> createState() => _ProfileAccountsPageState();
}

class _ProfileAccountsPageState extends State<ProfileAccountsPage> {

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
          'Связанные аккаунты'
        )
      ),
      body: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.red
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 15
                        ),
                        child: Text(
                          'Официальный сайт мэра\nМосквы mos.ru'
                        )
                      )
                    ]
                  )
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.orange
                    ),
                  ),
                  child: Text(
                    'Связать'
                  ),
                  onPressed: () {

                  }
                )
              ]
          )
        ]
      )
    );
  }
}
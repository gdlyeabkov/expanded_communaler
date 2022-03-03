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
  int userId = 0;
  String currentPassword = '';
  String password = '';
  String confirmPassword = '';
  late User currentUser;

  updatePassword(context) {
    String currentUserPassword = currentUser.password;
    bool isCurrentPasswordMatches = currentUserPassword == currentPassword;
    bool isPasswordsMatches = password == confirmPassword;
    int currentPasswordFieldLength = currentPassword.length;
    bool isCurrentPasswordFieldFilled = currentPasswordFieldLength >= 1;
    int passwordFieldLength = password.length;
    bool isPasswordFieldFilled = passwordFieldLength >= 1;
    int confirmPasswordFieldLength = confirmPassword.length;
    bool isConfirmPasswordFieldFilled = confirmPasswordFieldLength >= 1;
    bool isFieldsFilled = isCurrentPasswordFieldFilled || isPasswordFieldFilled || isConfirmPasswordFieldFilled;
    bool isCanUpdate = isCurrentPasswordMatches && isPasswordsMatches && isFieldsFilled;
    if (isCanUpdate) {
      handler.updateUserPassword(userId, password);
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
      bool isCurrentPasswordFieldNotFilled = !isCurrentPasswordFieldFilled;
      if (isCurrentPasswordFieldNotFilled) {
        msg += 'Поле \"Текущий пароль\" не заполнено\n';
      }
      bool isPasswordFieldNotFilled = !isPasswordFieldFilled;
      if (isPasswordFieldNotFilled) {
        msg += 'Поле \"Новый пароль\" не заполнено\n';
      }
      bool isConfirmPasswordFieldNotFilled = !isConfirmPasswordFieldFilled;
      if (isConfirmPasswordFieldNotFilled) {
        msg += 'Поле \"Повторите пароль\" не заполнено\n';
      }
      bool isCurrentPasswordNotMatches = !isCurrentPasswordMatches;
      if (isCurrentPasswordNotMatches) {
        msg += 'Поле \"Текущий пароль\" не совпадает\n';
      }
      bool isPasswordsNotMatches = !isPasswordsMatches;
      if (isPasswordsNotMatches) {
        msg += 'Поля \"Новый пароль\" и \"Повторите пароль\" не совпадают';
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
        handler.retrieveUsers().then((value) {
          for (User user in value) {
            int currentUserId = user.id!;
            bool isMyUser = currentUserId == userId;
            if (isMyUser) {
              currentUser = user;
              break;
            }
          }
        });
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
          'Изменить пароль'
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'После изменения пароля произойдет выход\nиз аккаунта на всех устройствах, сайтах и\nприложениях, где вошли с текущим паролем.'
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                currentPassword = value;
              });
            },
            obscureText: true,
            decoration: new InputDecoration.collapsed(
              hintText: 'Текущий пароль',
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
              hintText: 'Новый пароль',
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
          TextButton(
            child: Text(
              'Изменить пароль'
            ),
            onPressed: () {
              updatePassword(context);
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
        ]
      )
    );
  }
}
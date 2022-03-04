import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';
import 'models.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {

  int userId = 0;
  late DatabaseHandler handler;
  User currentUser = User(
    id: 0,
    thirdname: '',
    secondname: '',
    phone: '',
    password: '',
    name: '',
    login: '',
    gender: '',
    firstname: '',
    born: '',
    email: 0,
    address: ''
  );

  getFullName() {
    String firstName = currentUser.firstname;
    String secondName = currentUser.secondname;
    String thirdName = currentUser.thirdname;
    String fullName = '${firstName} ${secondName} ${thirdName}';
    return fullName;
  }

  getShortName() {
    String firstName = currentUser.firstname;
    String secondName = currentUser.secondname;
    List<String> firstNameLetters = firstName.split('');
    String firstLetterOfFirstName = firstNameLetters[0];
    String upperFirstLetterOfFirstName = firstLetterOfFirstName.toUpperCase();
    List<String> secondNameLetters = secondName.split('');
    String firstLetterOfSecondName = secondNameLetters[0];
    String upperFirstLetterOfSecondName = firstLetterOfSecondName.toUpperCase();
    String shortName = '${upperFirstLetterOfFirstName}${upperFirstLetterOfSecondName}';
    return shortName;
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

    return (
      Scaffold(
        appBar: AppBar(
          title: Text(
            'Профиль'
          )
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 150, 150, 150),
                shape: BoxShape.circle
              ),
              child: Center(
                child: Text(
                  getShortName(),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                )
              )
            ),
            Text(
              getFullName()
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Личные данные'
                  ),
                  Icon(
                    Icons.chevron_right
                  )
                ]
              ),
              onTap: () {
                // Navigator.pushNamed(context, '/profile/data');
                Navigator.pushNamed(
                  context,
                  '/profile/data',
                  arguments: {
                  'userId': userId
                  }
                );
              }
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Контакты'
                  ),
                  Icon(
                    Icons.chevron_right
                  )
                ]
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile/contacts');
              }
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Изменить пароль'
                  ),
                  Icon(
                    Icons.chevron_right
                  )
                ]
              ),
              onTap: () {
                // Navigator.pushNamed(context, '/profile/password');
                Navigator.pushNamed(
                  context,
                  '/profile/password',
                  arguments: {
                    'userId': userId
                  }
                );
              }
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Подписки'
                  ),
                  Icon(
                    Icons.chevron_right
                  )
                ]
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile/subs');
              }
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Безопасность'
                  ),
                  Icon(
                    Icons.chevron_right
                  )
                ]
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile/security');
              }
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Связанные аккаунты'
                  ),
                  Icon(
                    Icons.chevron_right
                  )
                ]
              ),
              onTap: () {
                Navigator.pushNamed(context, '/profile/accounts');
              }
            ),
            Divider(
              thickness: 1.0,
            ),
            TextButton(
              child: Text(
                'Выйти из аккаунта'
              ),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Сообщение'),
                    content: Container(
                      child: Column(
                        children: [
                          Text(
                            'Вы хотите выйти из личного\nкабинета?'
                          )
                        ]
                      )
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/main');
                          // return Navigator.pop(context, 'OK');
                        },
                        child: const Text('ВЫЙТИ')
                      ),
                      TextButton(
                        onPressed: () {
                          return Navigator.pop(context, 'Cancel');
                        },
                        child: const Text('ОТМЕНА')
                      )
                    ]
                  )
                );
              }
            )
          ]
        )
      )
    );
  }
}
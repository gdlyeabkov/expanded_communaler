import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {

  int userId = 0;

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
                  'РД',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                )
              )
            ),
            Text(
              'Родион Дьяков'
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
                Navigator.pushNamed(context, '/profile/password');
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
                Navigator.pushNamed(context, '/main');
              }
            )
          ]
        )
      )
    );
  }
}
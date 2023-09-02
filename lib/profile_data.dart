import 'package:flutter/material.dart';
import 'package:receipts/contacts.dart';
import 'package:receipts/personalarea.dart';

import 'db.dart';
import 'models.dart';

class ProfileDataPage extends StatefulWidget {

  const ProfileDataPage({Key? key}) : super(key: key);

  @override
  State<ProfileDataPage> createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {

  late DatabaseHandler handler;
  String firstName = '';
  String secondName = '';
  String thirdName = '';
  String born = '';
  Gender selectedGender = Gender.none;
  int userId = 0;

  setBorn(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(
          days: 365 * 75
        )
      ),
      lastDate: DateTime.now().add(
        Duration(
          days: 0
        )
      )
    );
    setState(() {
      bool isDatePick = pickedDate != null;
      if (isDatePick) {
        int dateTimeDay = pickedDate.day;
        int dateTimeMonth = pickedDate.month;
        int dateTimeYear = pickedDate.year;
        String rawDateTimeDay = dateTimeDay.toString();
        int rawDateTimeDayLength = rawDateTimeDay.length;
        bool isAddDayPrefix = rawDateTimeDayLength == 1;
        if (isAddDayPrefix) {
          rawDateTimeDay = '0${rawDateTimeDay}';
        }
        String rawDateTimeMonth = dateTimeMonth.toString();
        int rawDateTimeMonthLength = rawDateTimeMonth.length;
        bool isAddMonthPrefix = rawDateTimeMonthLength == 1;
        if (isAddMonthPrefix) {
          rawDateTimeMonth = '0${rawDateTimeMonth}';
        }
        born = '${rawDateTimeDay}.${rawDateTimeMonth}.${dateTimeYear}';
      }
    });
  }

  saveData(context) {
    int firstNameFieldLength = firstName.length;
    bool isFirstNameFieldFilled = firstNameFieldLength >= 1;
    int secondNameFieldLength = secondName.length;
    bool isSecondNameFieldFilled = secondNameFieldLength >= 1;
    int thirdNameFieldLength = thirdName.length;
    bool isThirdNameFieldFilled = thirdNameFieldLength >= 1;
    bool isFieldsFilled = isFirstNameFieldFilled || isSecondNameFieldFilled || isThirdNameFieldFilled;
    if (isFieldsFilled) {
      String rawGender = '';
      bool isMale = selectedGender == Gender.male;
      bool isFemale = selectedGender == Gender.female;
      if (isMale) {
        rawGender = 'Мужской';
      } else if (isFemale) {
        rawGender = 'Женский';
      }
      handler.updateUserData(userId, firstName, secondName, thirdName, born, rawGender);
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
      bool isFirstNameFieldNotFilled = !isFirstNameFieldFilled;
      if (isFirstNameFieldNotFilled) {
        msg += 'Поле \"Фамилия\" не заполнено\n';
      }
      bool isSecondNameFieldNotFilled = !isSecondNameFieldFilled;
      if (isSecondNameFieldNotFilled) {
        msg += 'Поле \"Имя\" не заполнено\n';
      }
      bool isThirdNameFieldNotFilled = !isThirdNameFieldFilled;
      if (isThirdNameFieldNotFilled) {
        msg += 'Поле \"Отчество\" не заполнено\n';
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
              String currentUserFirstName = user.firstname;
              String currentUserSecondName = user.secondname;
              String currentUserThirdName = user.thirdname;
              String userGender = user.gender;
              Gender gender = Gender.none;
              bool isMale = userGender == 'Мужской';
              bool isFemale = userGender == 'Женский';
              if (isMale) {
                gender = Gender.male;
              } else if (isFemale) {
                gender = Gender.female;
              }
              String userBorn = user.born;
              firstName = currentUserFirstName;
              secondName = currentUserSecondName;
              thirdName = currentUserThirdName;
              selectedGender = gender;
              born = userBorn;
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
          'Личные данные'
        ),
        actions: [
          TextButton(
            child: Text(
              'Сохранить'
            ),
            onPressed: () {
              saveData(context);
            }
          )
        ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: TextEditingController(
              text: firstName
            ),
            onChanged: (value) {
              setState(() {
                firstName = value;
              });
            },
            decoration: new InputDecoration.collapsed(
              hintText: 'Фамилия',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0
                )
              )
            )
          ),
          TextField(
            controller: TextEditingController(
                text: secondName
            ),
            onChanged: (value) {
              setState(() {
                secondName = value;
              });
            },
            decoration: new InputDecoration.collapsed(
              hintText: 'Имя',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0
                )
              )
            )
          ),
          TextField(
            controller: TextEditingController(
              text: thirdName
            ),
            onChanged: (value) {
              setState(() {
                thirdName = value;
              });
            },
            decoration: new InputDecoration.collapsed(
              hintText: 'Отчество',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0
                )
              )
            )
          ),
          DropdownButton<String>(
            value: born,
            icon: const Icon(
              Icons.arrow_drop_down
            ),
            isExpanded: true,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onTap: () {
              setBorn(context);
            },
            onChanged: (String? newValue) {

              setState(() {
                born = newValue!;
              });
            },
            items: [
              DropdownMenuItem(
                child: Text(
                  born
                ),
                value: born
              )
            ]
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<Gender>(
                    value: Gender.male,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    }
                  ),
                  Text(
                    'Мужской'
                  )
                ]
              ),
              Row(
                children: [
                  Radio<Gender>(
                    value: Gender.female,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    }
                  ),
                  Text(
                    'Женский'
                  )
                ]
              )
            ]
          )
        ],
      ),
    );
  }

}
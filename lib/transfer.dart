import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';
import 'models.dart';
// import 'package:torch_light/torch_light.dart';
// import 'package:flash_light/flash_light.dart';
// import 'package:torch_compat/torch_compat.dart';

class TransferPage extends StatefulWidget {

  const TransferPage({Key? key}) : super(key: key);

  @override
  State<TransferPage> createState() => _TransferPageState();

}

class _TransferPageState extends State<TransferPage> {

  bool isFlashLightEnabled = false;
  late DatabaseHandler handler;
  int? amountId = 0;
  int userId = 0;
  Amount currentAmount = Amount(
    provider: '',
    number: '',
    email: 0,
    cost: 0,
    id: 0,
    status: '',
    user: 0,
    datetime: ''
  );

  /*toggleFlashLight() async {
    try {
      final isTorchAvailable = await TorchLight.isTorchAvailable();
      if (isTorchAvailable || true) {
        print('есть разрешение для фонарика');
        setState(() {
          isFlashLightEnabled = !isFlashLightEnabled;
        });
        if (isFlashLightEnabled) {
          try {
            TorchLight.enableTorch();
          } on EnableTorchExistentUserException catch (e) {
            // The camera is in use
            print('The camera is in use');
          } on EnableTorchNotAvailableException catch (e) {
            // Torch was not detected
            print('Torch was not detected');
          } on EnableTorchException catch (e) {
            // Torch could not be enabled due to another error
            print('Torch could not be enabled due to another error');
          }
        } else {
          try {
            TorchLight.disableTorch();
          } on DisableTorchExistentUserException catch (e) {
            // The camera is in use
            print('The camera is in use');
          } on DisableTorchNotAvailableException catch (e) {
            // Torch was not detected
            print('Torch was not detected');
          } on DisableTorchException catch (e) {
            // Torch could not be disabled due to another error
            print('Torch could not be disabled due to another error');
          }
        }
      }
    } on Exception catch (_) {
      // Handle error
      print('нет разрешения для фонарика');
    }
  }*/


  @override
  initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {
        handler.retrieveAmounts().then((value) {
          for (Amount amount in value) {
            int currentAmountId = amount.id!;
            bool isMyAmount = currentAmountId == amountId;
            if (isMyAmount) {
              currentAmount = amount;
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
        print(arguments['amountId']);
        amountId = arguments['amountId'];
        userId = arguments['userId'];
      }
    });

    return (
      Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 15
                ),
                child: Icon(
                  Icons.circle
                )
              ),
              Text(
                currentAmount.number,
                style: TextStyle(
                  fontSize: 14
                )
              )
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                // toggleFlashLight();
              },
              child: Icon(
                Icons.flashlight_on,
                color: Color.fromARGB(100, 255, 255, 255),
              )
            )
          ]
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 255, 255, 255)
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 200, 200, 200)
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(
                        MediaQuery.of(context).size.width,
                        45.0
                      )
                    )
                  ),
                  child: Text(
                    'Передать показания'
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/area',
                      arguments: {
                        'userId': userId
                      }
                    );
                  }
                )
              ]
            )
          )
        )
      )
    );
  }
}
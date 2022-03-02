import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {

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
                'Передача показаний',
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
        body: Column(
          children: [

          ]
        )
      )
    );
  }
}
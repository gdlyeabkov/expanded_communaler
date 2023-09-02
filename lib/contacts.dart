import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class ContactsPage extends StatefulWidget {

  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();

}

class _ContactsPageState extends State<ContactsPage> {

  String provider = 'Поставщик услуг';
  List<String> providers = [
    'Поставщик услуг',
    'АО МосОблЕИРЦ',
    'АО Мосэенргосбыт'
  ];

  openPhoneDialog() async {

    showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) => BottomSheet(
        onClosing: () {

        },
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Text(
                  'Позвонить в контактный центр',
                  style: TextStyle(
                    fontWeight: FontWeight.w900
                  )
                ),
                Text(
                  'Нажмите чтобы выбрать номер телефона'
                ),
                GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'АО Мосэенргосбыт',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 200, 200, 200)
                        )
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 25
                            ),
                            child: Text(
                              '+7 (499) 550-9-550'
                            )
                          )
                        ]
                      )
                    ]
                  ),
                  onTap: () async {
                    final String url = 'tel://84995509550';
                    if (await UrlLauncher.canLaunch(url))
                      UrlLauncher.launch(url);
                  }
                ),
                Divider(
                  thickness: 1.0,
                ),
                GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ООО \"МосОблЕИРЦ\"',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromARGB(255, 200, 200, 200)
                        )
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 25
                            ),
                            child: Text(
                              '+7 (496) 245-15-99'
                            )
                          )
                        ]
                      )
                    ]
                  ),
                  onTap: () async {
                    final String url = 'tel://84962451599';
                    if (await UrlLauncher.canLaunch(url))
                    UrlLauncher.launch(url);
                  }
                )
              ]
            ),
            padding: EdgeInsets.all(
              15
            )
          );
        }
      )
    );

  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Контакты'
          ),
          actions: [
            TextButton(
              onPressed: () {
                openPhoneDialog();
              },
              child: Icon(
                Icons.phone
              )
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Список'
              ),
              Tab(
                text: 'Карта'
              )
            ]
          )
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    value: provider,
                    icon: const Icon(
                      Icons.arrow_drop_down
                    ),
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        provider = newValue!;
                      });
                    },
                    items: providers.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  )
                ),
                (
                  (provider == 'АО МосОблЕИРЦ' || provider == 'Поставщик услуг') ?
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            15
                          ),
                          margin: EdgeInsets.all(
                            15
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                'Управление ЕИРЦ \"Пушкино\"(Пушкинский район)\nСеверо-Восточный отдел ЕИРЦ'
                              ),
                              Text(
                                '141200, Московская область, г. Пушкино, ул.\nОстровсого, д. 22'
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 15
                                    ),
                                    child: Text(
                                      'Пн-пт: с 8-00 до 20-00'
                                    )
                                  )
                                ]
                              )
                            ]
                          )
                        )
                      ]
                    )
                  :
                    Column(

                    )
                ),
                (
                  (provider == 'АО Мосэенргосбыт' || provider == 'Поставщик услуг') ?
                  Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(
                                15
                            ),
                            margin: EdgeInsets.all(
                                15
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            child: Column(
                                children: [
                                  Text(
                                      'Управление ЕИРЦ \"Пушкино\"(Пушкинский район)\nСеверо-Восточный отдел ЕИРЦ'
                                  ),
                                  Text(
                                      '141200, Московская область, г. Пушкино, ул.\nОстровсого, д. 22'
                                  ),
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                            Icons.timer
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 15
                                            ),
                                            child: Text(
                                                'Пн-пт: с 8-00 до 20-00'
                                            )
                                        )
                                      ]
                                  )
                                ]
                            )
                        )
                      ]
                  )
                      :
                  Column(

                  )
                )
              ]
            ),
            FlutterMap(
              options: MapOptions(
                center: latLng.LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) {
                    return Text("© OpenStreetMap contributors");
                  },
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: latLng.LatLng(51.5, -0.09),
                      builder: (ctx) =>
                          Container(
                            child: Icon(
                                Icons.near_me
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            )
          ]
        )
      )
    );
  }
}

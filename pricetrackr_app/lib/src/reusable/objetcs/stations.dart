import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import '../../responsive/responsive-method.dart';

class Station {
  //Propiedades del objeto
  late int id;
  late String nombre;
  late double lat;
  late double long;
  late String magna;
  late String premium;
  late String diesel;

  //Constructor
  Station({
    int? id,
    String? nombre,
    double? lat,
    double? long,
    String? magna,
    String? premium,
    String? diesel,
  }) {
    this.id = id ?? 0;
    this.nombre = nombre ?? '';
    this.lat = lat ?? 0;
    this.long = long ?? 0;
    this.magna = magna ?? '';
    this.premium = premium ?? '';
    this.diesel = diesel ?? '';
  }

  //Getters
  int getId() {
    return id;
  }

  String getNombre() {
    return nombre;
  }

  double getLat() {
    return lat;
  }

  double getLong() {
    return long;
  }

  String getMagna() {
    return magna;
  }

  String getPremium() {
    return premium;
  }

  String getDiesel() {
    return diesel;
  }

  //API
  Future<List<Station>> getRecentsByMagna() async {
    List<Station> stations = [];

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://192.168.0.18/backend/pricetrackr/api/estaciones/getByMagna/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> answer = {};

      try {
        answer = json.decode(await response.stream.bytesToString()) ?? {};

        if (answer.isNotEmpty) {
          int code = answer['code'] ?? 500;

          if (code == 0) {
            List<dynamic> data = answer['data'] ?? [];

            if (data.length > 5) {
              for (int i = 0; i < 5; i++) {
                Map<String, dynamic> item = data[i] ?? {};

                stations.add(Station(
                  id: item['id'] ?? 0,
                  nombre: item['nombre'] ?? '',
                  magna: item['magna'] ?? '',
                  premium: item['premium'] ?? '',
                  diesel: item['diesel'] ?? '',
                ));
              }
            }
          } else {
            print(answer['msg']);
          }
        }
      } catch (e) {
        print('La respuesta no cumple con formato JSON.');
      }
    } else {
      print(response.reasonPhrase);
    }

    return stations;
  }

  Future<List<String>> getPromedio() async {
    List<String> prices = [];

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://192.168.0.18/backend/pricetrackr/api/estaciones/getPromedio/'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> answer = {};

      try {
        answer = json.decode(await response.stream.bytesToString()) ?? {};

        if (answer.isNotEmpty) {
          int code = answer['code'] ?? 500;

          if (code == 0) {
            Map<String, dynamic> data = answer['data'] ?? {};

            prices.add(data['magna'] ?? '');
            prices.add(data['premium'] ?? '');
            prices.add(data['diesel'] ?? '');
          } else {
            print(answer['msg']);
          }
        }
      } catch (e) {
        print('La respuesta no cumple con formato JSON.');
      }
    } else {
      print(response.reasonPhrase);
    }

    return prices;
  }

  //Widgets

  //------Precios promedio
  Widget averagePricesCard(BuildContext context) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    double vw = responsive['vw'];
    double vh = responsive['vh'];
    double ratio = responsive['ratio'];
    double vr = vh / ratio;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * vw),
      child: FutureBuilder<List<String>>(
        future: Station().getPromedio(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData) {
            List<String> prices = snapshot.data!;

            if (prices.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Precios promedio',
                    style: TextStyle(
                      height: 1,
                      fontSize: 3.5 * vw,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 5 * vr, horizontal: 10 * vw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 0.66 * vw),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 15 * vw,
                          height: 12.5 * vr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prices[0],
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 4 * vw,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              Container(
                                width: 10 * vw,
                                height: 2 * vr,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(2 * vr),
                                ),
                              ),
                              Text(
                                'Magna',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 2.25 * vw,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 15 * vw,
                          height: 12.5 * vr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prices[1],
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 4 * vw,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              Container(
                                width: 10 * vw,
                                height: 2 * vr,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(2 * vr),
                                ),
                              ),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 2.25 * vw,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 15 * vw,
                          height: 12.5 * vr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prices[2],
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 4 * vw,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              Container(
                                width: 10 * vw,
                                height: 2 * vr,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  borderRadius: BorderRadius.circular(2 * vr),
                                ),
                              ),
                              Text(
                                'Diesel',
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 2.25 * vw,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Text('Vacío');
            }
          } else {
            return Text('Cargando...');
          }
        },
      ),
    );
  }

  //------Precios más bajos
  Widget lowestPrices(BuildContext context) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    double vw = responsive['vw'];
    double vh = responsive['vh'];
    double ratio = responsive['ratio'];
    double vr = vh / ratio;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * vw),
      child: FutureBuilder<List<Station>>(
        future: Station().getRecentsByMagna(),
        builder: (context, AsyncSnapshot<List<Station>> snapshot) {
          if (snapshot.hasData) {
            List<Station> stations = snapshot.data!;

            if (stations.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Precios más bajos',
                    style: TextStyle(
                      height: 1,
                      fontSize: 3.5 * vw,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Container(
                    width: double.infinity,
                    height: ((10.5 * vr) * stations.length) + (1 * vr),
                    padding: EdgeInsets.symmetric(horizontal: 4 * vw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 0.66 * vw),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: ((10.5 * vr) * stations.length) + (1 * vr),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).dividerColor,
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: stations.length,
                        itemBuilder: (context, index) {
                          Station station = stations[index];

                          return Container(
                            margin: index != 4
                                ? EdgeInsets.only(bottom: 0.25 * vr)
                                : null,
                            width: double.infinity,
                            height: 10.5 * vr,
                            color: Theme.of(context).backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 67.5 * vw,
                                  child: Text(
                                    station.getNombre(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 2.75 * vw,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .unselectedWidgetColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10 * vw,
                                  child: Text(
                                    station.getMagna(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 2.75 * vw,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Text('Vacío');
            }
          } else {
            return Text('Cargando...');
          }
        },
      ),
    );
  }
}

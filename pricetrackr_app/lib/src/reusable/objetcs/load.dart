import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:flutter/material.dart';

import '../../responsive/responsive-method.dart';

class Load {
  //Propiedades del objeto
  late int id;
  late String fecha;
  late String importe;
  late String tipo;
  late String estacion;

  Load({
    int? id,
    String? fecha,
    String? importe,
    String? tipo,
    String? estacion,
  }) {
    this.id = id ?? 0;
    this.fecha = fecha ?? '';
    this.importe = importe ?? '';
    this.tipo = tipo ?? '';
    this.estacion = estacion ?? '';
  }

  //Getters
  int getId() {
    return id;
  }

  String getFecha() {
    return fecha;
  }

  String getImporte() {
    return importe;
  }

  String getTipo() {
    return tipo;
  }

  Color getColor(BuildContext context) {
    switch (tipo) {
      case 'Magna':
        return Theme.of(context).primaryColor;
      case 'Premium':
        return Theme.of(context).primaryColorLight;
      case 'Diesel':
        return Theme.of(context).primaryColorDark;
      default:
        return Theme.of(context).primaryColorDark;
    }
  }

  String getEstacion() {
    return estacion;
  }

  //API

  Future<List<Load>> getRecents() async {
    String token = '64da9d71498ef';
    List<Load> loads = [];

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.0.18/backend/pricetrackr/api/cargas/getRecents/'));
    request.fields.addAll({'token': token});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> answer = {};

      try {
        answer = json.decode(await response.stream.bytesToString()) ?? {};

        if (answer.isNotEmpty) {
          int code = answer['code'] ?? 500;

          if (code == 0) {
            List<dynamic> data = answer['data'] ?? [];

            if (data.length > 0) {
              for (int i = 0; i < 5; i++) {
                Map<String, dynamic> item = data[i] ?? {};

                int id = item['id'] ?? 0;
                String fecha = item['fecha'] ?? '';
                String importe = item['importe'] ?? '';
                String tipo = item['tipo'] ?? '';
                String estacion = item['estacion'] ?? '';

                loads.add(Load(
                  id: id,
                  fecha: fecha,
                  importe: importe,
                  tipo: tipo,
                  estacion: estacion,
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

    return loads;
  }

  //WIDGETS

  Widget recentsList(BuildContext context) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    double vw = responsive['vw'];
    double vh = responsive['vh'];
    double ratio = responsive['ratio'];
    double vr = vh / ratio;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * vw),
      child: FutureBuilder<List<Load>>(
        future: Load().getRecents(),
        builder: (context, AsyncSnapshot<List<Load>> snapshot) {
          if (snapshot.hasData) {
            List<Load> loads = snapshot.data!;

            if (loads.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Cargas más recientes',
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
                    height: ((14 * vr) * loads.length) + (1 * vr),
                    padding: EdgeInsets.symmetric(horizontal: 4 * vw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 0.66 * vw),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: ((14 * vr) * loads.length) + (1 * vr),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).dividerColor,
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: loads.length,
                        itemBuilder: (context, index) {
                          Load load = loads[index];

                          return Container(
                            margin: index != 4
                                ? EdgeInsets.only(bottom: 0.25 * vr)
                                : null,
                            width: double.infinity,
                            height: 14 * vr,
                            color: Theme.of(context).backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 62.5 * vw,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        load.getEstacion(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: 2.75 * vw,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .unselectedWidgetColor,
                                        ),
                                      ),
                                      SizedBox(height: 1 * vr),
                                      Text(
                                        load.getFecha(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: 2.25 * vw,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .unselectedWidgetColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 16 * vw,
                                  child: Text(
                                    load.getImporte(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 2.75 * vw,
                                      fontWeight: FontWeight.w500,
                                      color: load.getColor(context),
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

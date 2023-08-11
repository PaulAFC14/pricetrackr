import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:flutter/material.dart';

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
    String token = '64d58e66aed18';
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
}

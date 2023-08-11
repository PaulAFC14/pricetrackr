// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../responsive/responsive-method.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

class Logo extends StatelessWidget {
  late BuildContext context;
  Logo(this.context, {super.key}) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = vh / ratio;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Price',
          style: TextStyle(
            height: 1,
            fontSize: 5 * vw,
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Trackr',
          style: TextStyle(
            height: 1,
            fontSize: 5 * vw,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

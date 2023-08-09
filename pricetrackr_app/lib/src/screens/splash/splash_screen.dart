import 'package:flutter/material.dart';

import '../../responsive/responsive-method.dart';

late int responsiveId;
late double vw;
late double vh;
late double ratio;
late double vr;

// ignore: camel_case_types, must_be_immutable
class Splash_Screen extends StatefulWidget {
  late BuildContext context;
  Splash_Screen(this.context, {super.key}) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    responsiveId = responsive['id'];
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = vh / ratio;
  }

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100 * vw,
            height: 41.5 * vh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 33.3 * vw,
                  height: 33.3 * vw,
                  child: Image.asset('assets/logos/logoverde.png'),
                )
              ],
            ),
          ),
          Container(
            width: 100 * vw,
            height: 5 * vh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    height: 1,
                    fontSize: 10 * vw,
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Trackr',
                  style: TextStyle(
                    height: 1,
                    fontSize: 10 * vw,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100 * vw,
            height: 41.5 * vh,
          )
        ],
      ),
    );
  }
}

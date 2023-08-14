import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pricetrackr_app/src/reusable/objetcs/load.dart';
import 'package:pricetrackr_app/src/reusable/objetcs/stations.dart';
import 'package:pricetrackr_app/src/reusable/widgets/logo.dart';
import 'package:pricetrackr_app/src/reusable/widgets/menu.dart';

import '../../responsive/responsive-method.dart';

late double vw;
late double vh;
late double ratio;
late double vr;

// ignore: must_be_immutable
class Home_Screen extends StatefulWidget {
  late BuildContext context;
  Home_Screen(this.context, {super.key}) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = vh / ratio;
  }

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            width: 100 * vw,
            padding: EdgeInsets.symmetric(horizontal: 5 * vw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: 6 * vw,
                    height: 6 * vw,
                  ),
                ),
                Logo(context),
                GestureDetector(
                  child: Container(
                    width: 6 * vw,
                    height: 6 * vw,
                    child: Icon(
                      Iconsax.setting,
                      size: 6 * vw,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 7.5 * vr,
            color: const Color.fromARGB(255, 233, 230, 230),
            child: Center(child: Text('Pendiente barra busqueda')),
          ),
          SizedBox(height: 5 * vr),
          Station().averagePricesCard(context),
          SizedBox(height: 5 * vr),
          Station().lowestPrices(context),
          SizedBox(height: 5 * vr),
          Load().recentsList(context),
          SizedBox(height: 10 * vr),
        ],
      ),
      bottomNavigationBar: Menu(
        context,
        index: 2,
      ),
    );
  }
}

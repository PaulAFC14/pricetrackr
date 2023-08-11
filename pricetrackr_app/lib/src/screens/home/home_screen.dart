import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pricetrackr_app/src/reusable/objetcs/load.dart';
import 'package:pricetrackr_app/src/reusable/objetcs/stations.dart';
import 'package:pricetrackr_app/src/reusable/widgets/logo.dart';

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
          Padding(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 62.5 * vw,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
          ),
          SizedBox(height: 10 * vr),
        ],
      ),
    );
  }
}

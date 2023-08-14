import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pricetrackr_app/src/reusable/methods/routes.dart';

import '../../responsive/responsive-method.dart';

late double vw;
late double vh;
late double ratio;
late double vr;
late int page;

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  late BuildContext context;
  Menu(this.context, {super.key, required int index}) {
    Map<String, dynamic> responsive =
        ResponsiveData(context: context).getAspectRatio();
    vw = responsive['vw'];
    vh = responsive['vh'];
    ratio = responsive['ratio'];
    vr = vh / ratio;

    page = index;
  }

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20 * vr,
      padding: EdgeInsets.symmetric(horizontal: 5 * vw),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(51, 155, 155, 155),
              offset: Offset(0, -4),
              blurRadius: 20),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Routes(context),
            child: Container(
              width: 16 * vw,
              height: 20 * vr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: Icon(
                      (page == 0) ? Iconsax.location5 : Iconsax.location,
                      color: (page == 0)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                      size: 6 * vw,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Text(
                    'Estaciones',
                    style: TextStyle(
                      height: 1,
                      fontSize: 2.25 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 0)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context),
            child: Container(
              width: 16 * vw,
              height: 20 * vr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: Icon(
                      (page == 1)
                          ? Iconsax.dollar_circle4
                          : Iconsax.dollar_circle,
                      color: (page == 1)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                      size: 6 * vw,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Text(
                    'Precios',
                    style: TextStyle(
                      height: 1,
                      fontSize: 2.25 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 1)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context),
            child: Container(
              width: 16 * vw,
              height: 20 * vr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: Icon(
                      (page == 2) ? Iconsax.home_25 : Iconsax.home_2,
                      color: (page == 2)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                      size: 6 * vw,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Text(
                    'Inicio',
                    style: TextStyle(
                      height: 1,
                      fontSize: 2.25 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 2)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context),
            child: Container(
              width: 16 * vw,
              height: 20 * vr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: Icon(
                      (page == 3)
                          ? Iconsax.clipboard_text5
                          : Iconsax.clipboard_text,
                      color: (page == 3)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                      size: 6 * vw,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Text(
                    'Cargas',
                    style: TextStyle(
                      height: 1,
                      fontSize: 2.25 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 3)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Routes(context),
            child: Container(
              width: 16 * vw,
              height: 20 * vr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 6 * vw,
                    height: 6 * vr,
                    child: Icon(
                      (page == 4) ? Iconsax.heart5 : Iconsax.heart,
                      color: (page == 4)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                      size: 6 * vw,
                    ),
                  ),
                  SizedBox(height: 1 * vr),
                  Text(
                    'Favoritas',
                    style: TextStyle(
                      height: 1,
                      fontSize: 2.25 * vw,
                      fontWeight: FontWeight.w400,
                      color: (page == 4)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

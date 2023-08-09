/*This method can be use to determinate aspect ratio of the screen of target device, 
it takes screen size, then based in the value of (height/width), choose in wich of the most commons AR should be.*/

import 'package:flutter/material.dart';

class ResponsiveData {
  late BuildContext context;
  ResponsiveData({required this.context});

  Map<String, dynamic> getDimensions() {
    Map<String, dynamic> dimensions;
    double width =
        MediaQuery.of(context).size.width; //Deteminates screen width.
    double height =
        MediaQuery.of(context).size.height; //Determinates screen height.
    double vw = width / 100; //Divides the width value in 100 different units.
    double vh = height / 100; //Divides the height value in 100 different units.

    double ratio = height / width;

    dimensions = {'vw': vw, 'vh': vh, 'ratio': ratio};

    return dimensions;
  }

  Map<String, dynamic> getAspectRatio() {
    Map<String, dynamic>
        arData; //All the information returned from this method.
    bool
        verticalView; //This bool variable determinates if the orientation of device is vertical;
    int id =
        10; //This variable can be used to chose wich AR select from a list of options.

    double width = 100;
    width = MediaQuery.maybeOf(context)!.size.width; //Deteminates screen width.
    double height = 100;
    height =
        MediaQuery.maybeOf(context)!.size.height; //Determinates screen height.
    double vw = width / 100; //Divides the width value in 100 different units.
    double vh = height / 100; //Divides the height value in 100 different units.

    //Determination of the device orientation.
    if (height > width) {
      verticalView = true;
    } else {
      verticalView = false;
    }

    double ar = height / width; //Calculate the decimal value of aspect ratio.

    //List of the most common aspect ratios.

    if (ar >= 1.6 && ar < 1.9) {
      id = 1;
    } else if (ar < 2.17) {
      id = 2;
    }

    //Determinates in wich is our device.
    /*if (ar < 1.24) {
      id = 0;
      aspectRatio = aspectsInfo[id];
      ar = 0.93;
    } else if (ar < 1.7) {
      id = 1;
      aspectRatio = aspectsInfo[id];
      ar = 1.24;
    } else if (ar < 2) {
      id = 2;
      aspectRatio = aspectsInfo[id];
      ar = 1.7;
    } else if (ar < 2.05) {
      id = 3;
      aspectRatio = aspectsInfo[id];
      ar = 2;
    } else if (ar < 2.11) {
      id = 4;
      aspectRatio = aspectsInfo[id];
      ar = 2.05;
    } else if (ar < 2.16) {
      id = 5;
      aspectRatio = aspectsInfo[id];
      ar = 2.11;
    } else if (ar < 2.22) {
      id = 6;
      aspectRatio = aspectsInfo[id];
      ar = 2.16;
    } else if (ar < 2.33) {
      id = 7;
      aspectRatio = aspectsInfo[id];
      ar = 2.22;
    } else if (ar < 2.44) {
      id = 8;
      aspectRatio = aspectsInfo[id];
      ar = 2.33;
    } else {
      id = 9;
      aspectRatio = aspectsInfo[id];
      ar = 2.44;
    }*/

    //Fill de answer with all the data
    arData = {
      'id': id,
      'ratio': ar,
      //'ratio': aspectRatio,
      'verticalOrientation': verticalView,
      'vw': vw,
      'vh': vh
    };

    return arData;
  }
}

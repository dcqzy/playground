import 'package:flutter/material.dart';

Image assetImage(String name, {double width, double height, BoxFit fit}) {
  return Image.asset('static/images/$name', width: width, height: height, fit: fit);
}

class CustomImages {
  static const String guide1 = 'guide1.png';

  static const String guide2 = 'guide2.png';

  static const String guide3 = 'guide3.png';

  static const String guide4 = 'guide4.png';

  static const String splash_bg = 'olb_stunned.jpg';

  static const String mahira = 'mahira.jpg';
}

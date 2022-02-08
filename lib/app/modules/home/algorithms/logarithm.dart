import 'dart:math';

import 'package:image/image.dart';

class Log {
  Image imagen;
  int c;
  Log(this.imagen, this.c);
}

/// Top level function
Future<Image> logarithmic(Log data) async {
  int wi = data.imagen.width;
  int he = data.imagen.height;
  for (int x = 0; x < wi; x++) {
    for (int y = 0; y < he; y++) {
      int red = getRed(data.imagen[y * wi + x]);
      int blue = getBlue(data.imagen[y * wi + x]);
      int green = getGreen(data.imagen[y * wi + x]);
      int newRed = (data.c * (log(red) / ln10)).clamp(0, 255).toInt();
      int newBlue = (data.c * (log(blue) / ln10)).clamp(0, 255).toInt();
      int newGreen = (data.c * (log(green) / ln10)).clamp(0, 255).toInt();
      data.imagen.setPixelRgba(x, y, newRed, newGreen, newBlue);
    }
  }
  return data.imagen;
}

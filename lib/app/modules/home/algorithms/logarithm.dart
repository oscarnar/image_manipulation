import 'dart:math';

import 'package:image/image.dart';

Future<Image> logarithmic(Log data) async {
  int width = data.image.width;
  int height = data.image.height;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      final red = getRed(data.image[y * width + x]);
      final blue = getBlue(data.image[y * width + x]);
      final green = getGreen(data.image[y * width + x]);
      int newRed = (data.c * (log(red) / ln10)).clamp(0, 255).toInt();
      int newBlue = (data.c * (log(blue) / ln10)).clamp(0, 255).toInt();
      int newGreen = (data.c * (log(green) / ln10)).clamp(0, 255).toInt();
      data.image.setPixelRgba(x, y, newRed, newGreen, newBlue);
    }
  }
  return data.image;
}

class Log {
  Image image;
  int c;
  Log(this.image, this.c);
}
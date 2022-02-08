import 'package:image/image.dart';

/// Top level function
Future<Image> naiveBlur(Image image) async {
  int width = image.width;
  int height = image.height;
  int kernel = 4;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int totalRed = 0;
      int totalGreen = 0;
      int totalBlue = 0;

      /// Here define limits for the kernel
      final minLimitX = (x - kernel).clamp(0, width - 1);
      final maxLimitX = (x + kernel).clamp(0, width - 1);
      final minLimitY = (y - kernel).clamp(0, height - 1);
      final maxLimitY = (y + kernel).clamp(0, height - 1);

      /// Here all pixel in the kernel are summed 
      for (int j = minLimitX; j < maxLimitX; j++) {
        for (int k = minLimitY; k < maxLimitY; k++) {
          totalRed += getRed(image[k * width + j]);
          totalBlue += getBlue(image[k * width + j]);
          totalGreen += getGreen(image[k * width + j]);
        }
      }

      final totalPixels = (maxLimitX - minLimitX) * (maxLimitY - minLimitY);

      /// Here the average is calculated
      int newRed = (totalRed / totalPixels).clamp(0, 255).toInt();
      int newBlue = (totalBlue / totalPixels).clamp(0, 255).toInt();
      int newGreen = (totalGreen / totalPixels).clamp(0, 255).toInt();
      image.setPixelRgba(x, y, newRed, newGreen, newBlue);
    }
  }
  return image;
}

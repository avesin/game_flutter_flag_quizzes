import 'dart:ui' as ui;

Future<ui.Image> removeBackground(ui.Image image) async {
  final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

  final pixels = byteData!.buffer.asUint8List();

  const targetR = 0;
  const targetG = 130;
  const targetB = 129;

  const tolerance = 60;

  for (int i = 0; i < pixels.length; i += 4) {
    int r = pixels[i];
    int g = pixels[i + 1];
    int b = pixels[i + 2];

    if ((r - targetR).abs() < tolerance &&
        (g - targetG).abs() < tolerance &&
        (b - targetB).abs() < tolerance) {
      pixels[i + 3] = 0; // alpha → transparent
    }
  }

  final descriptor = ui.ImageDescriptor.raw(
    await ui.ImmutableBuffer.fromUint8List(pixels),
    width: image.width,
    height: image.height,
    pixelFormat: ui.PixelFormat.rgba8888,
  );

  final codec = await descriptor.instantiateCodec();
  final frame = await codec.getNextFrame();

  return frame.image;
}

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WidgetBigQRCodeImage extends StatelessWidget {
  final String qrData;
  const WidgetBigQRCodeImage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320.0,
      width: 320.0,
      color: Colors.white,
      child: QrImage(
        data: qrData,
        version: QrVersions.auto,
        size: 320,
        gapless: false,
        embeddedImage: AssetImage('assets/ic_app_logo.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(80, 80),
        ),
      ),
    );
  }
}
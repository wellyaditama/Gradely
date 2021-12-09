import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WidgetSmallQRCodeImage extends StatelessWidget {
  final String qrData;
  const WidgetSmallQRCodeImage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      color: Colors.white,
      child: QrImage(
        data: qrData,
        version: QrVersions.auto,
        size: 50,
        gapless: false,
        embeddedImage: AssetImage('assets/ic_app_logo.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(15, 15),
        ),
      ),
    );
  }
}

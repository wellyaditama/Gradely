import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WidgetBigQRCodeImage extends StatelessWidget {
  final String qrData;
  const WidgetBigQRCodeImage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: QrImage(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        data: qrData,
        version: QrVersions.auto,
        size: 320,
        embeddedImage:
        const AssetImage('assets/ic_app_logo.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: const Size(50, 50),
        ),
        errorStateBuilder: (cxt, err) {
          return const Center(
            child: Text(
              "There is some problem...",
              textAlign: TextAlign.center,
            ),
          );
        },
      )
    );
  }
}
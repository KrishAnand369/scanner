import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;

  QRViewController? controller;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Future<void> reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(bottom: 20, child: buidResult()),
              Positioned(top: 20, child: buildControlButton()),
              Positioned(bottom: 100, child: addButton())
            ],
          ),
        ),
      );

  Widget buildControlButton() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FutureBuilder<bool?>(
      future: controller?.getFlashStatus(),
      builder: (context, snapshot) {if (snapshot.data!=null)
      {return Icon(snapshot.data!? Icons.flash_on_rounded:Icons.flash_off_rounded);}
      else{return Container();}}
     ),
     onPressed: () async {
      await controller?.toggleFlash();
      setState(() {});
    },
  ),
IconButton(
              icon:FutureBuilder(
      future: controller?.getCameraInfo(),
      builder: (context, snapshot) {
        if (snapshot.data!=null){
          return Icon(Icons.switch_camera_rounded);
          }
      else{
        return Container();}}
     
    ) ,
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              
            )
          ],
        ),
      );

  Widget buidResult() => Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.lightGreen),
      child: Text(
        barcode != null ? 'RESULT :${barcode!.code}' : 'Scan a QR Code',
        maxLines: 3,
      ));

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderRadius: 20,
          borderWidth: 15,
          borderColor: Colors.blue,
        ),
      );

  Widget addButton() => Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('add'))
          ],
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    /*FutureBuilder<bool?>(
      future: controller?.getFlashStatus(),
      builder: (context, snapshot) {if (snapshot.data!=null){return Icon(Icons.flash_off_rounded);}
      else{return Container();}}
     
    );*/

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}

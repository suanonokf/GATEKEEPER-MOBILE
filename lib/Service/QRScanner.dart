import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ScannerState();
}
class ScannerState extends State<QRScanner>{
  GlobalKey qrkey = GlobalKey(debugLabel: 'qr');
  QRViewController? qrViewController;
  String? ScannedData;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: QRView(
            key: qrkey,
            onQRViewCreated: _onQrViewCreated
        ),
      ),
    );
  }
  void _onQrViewCreated(QRViewController controller){
    this.qrViewController =controller;
    controller.scannedDataStream.listen((scanData){
      ScannedData=scanData.code;
    });
  }
  @override
  void dispose(){
    qrViewController?.dispose();
    super.dispose();
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:namer_app/Service/AppTheme.dart';

class QRScanner extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height/5,
      width: width/10,
      decoration: BoxDecoration(
        color: AppTheme().getColor(),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding:  EdgeInsets.fromLTRB(width/3.5,width/20,width/3.5,width/20),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute<void>(
                          builder: (context) => MobileScan()
                        )
                    );
                  },
                  icon: Icon(CupertinoIcons.qrcode_viewfinder,
                    size: 100,
                    color: AppTheme().getIconColor(),
                  )
              ),
              Text("Scan ID Card",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getIconColor())),)
            ],
          ),
        ),
      ),
    );
  }
}

class MobileScan extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => MobileScanState();

}

class MobileScanState extends State<MobileScan> {
  String mybarcode ="Scan ID Card";
  List<Barcode> barcodes =[];
  void _barcodeDetection(BarcodeCapture capture){
    barcodes=capture.barcodes;
    if(barcodes.isNotEmpty){
      setState(() {
        mybarcode=barcodes.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex:1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width/10),
                    child: IconButton(
                        color: AppTheme().getIconColor(),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          size: 30,
                          Icons.arrow_back_rounded,
                          semanticLabel: "Return",
                        )
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.width/20),
                child: MobileScanner(
                    onDetect: _barcodeDetection,
                ),
              ),
            ),
            Expanded(
              flex: 2,
                child: Padding(
                  padding:  EdgeInsets.all(30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme().getColor(),
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/20)
                    ),
                    child: Center(
                      child: Text("$mybarcode",style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),),
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

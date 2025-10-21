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

class MobileScan extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                    Icons.keyboard_return_rounded,
                  semanticLabel: "Return",
                )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width*0.85,
              child: MobileScanner(
                  onDetect: (capture){
                    List<Barcode> barcodes = capture.barcodes;
                    for(Barcode b in barcodes){
                      print("Barcode: $b");
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

}
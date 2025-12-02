import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/Service/AppTheme.dart';
import 'package:namer_app/Service/QRScanner.dart';
import 'package:namer_app/Service/StudentService.dart';
import 'package:namer_app/Sreen/HistoryScreen.dart';
import 'package:namer_app/Sreen/SettingScreen.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return HomeFrame();
  }
}

class HomeFrame extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> HomeFrameState();
}
class HomeFrameState extends State<HomeFrame>{
  int _selectedIndex=0;

  void _setIndex(int index){
    setState((){
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(), HistoryScreen(),SettingScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill,color: AppTheme().getIconColor(),size: 40,),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history_sharp,color: AppTheme().getIconColor(),size: 40,),label: "Search History"),
          BottomNavigationBarItem(icon:Icon(CupertinoIcons.settings,color: AppTheme().getIconColor(),size: 40,),label: "Settings")
        ],
        onTap: _setIndex,
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(175, 204, 255, 0.35),
        title:
        Text("Home",style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontWeight: FontWeight.bold,fontSize: 30)),),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Padding(
          padding: EdgeInsetsGeometry.all(MediaQuery.of(context).size.width/40),
          child: ListView(
           children: [
            QRScanner(),
            SizedBox(height: 30,),
            SearchBox()
           ],
        ),
      ),
    );
  }
}
class SearchBoxModel extends ChangeNotifier{
  String id="";
  String getId() => id;
  void setId(String newId){
    id = newId;
    notifyListeners();
  }
  List<String> History =[];
  List<String> getHistory(){
    if(id.isNotEmpty && !History.contains(id)){
      History.add(id);
      return History;
    }
    else{
      return History;
    }
  }
  void reset(){
    History=[];
    id="";
    notifyListeners();
  }
}
class SearchBox extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final searchBox = Provider.of<SearchBoxModel>(context,listen: false);
    var id = Provider.of<SearchBoxModel>(context).id;
    final idTextController = TextEditingController();

    final height = MediaQuery.of(context).size.height/2;
    final width =  MediaQuery.of(context).size.width/2;
    final  key = GlobalKey<FormState>();
    return Container(
      constraints: BoxConstraints(
        minHeight: height,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: AppTheme().getColor(),blurRadius: 2.8),
            BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.55),blurRadius: 0.8),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: height/10),
            child: Text("Search Student Info", style: GoogleFonts.notoSans(textStyle: TextStyle(color: AppTheme().getHeaderColor(),fontSize: 25,fontWeight: FontWeight.bold)),),
          ),
          SizedBox(height: height/20,),
          Form(
            key: key,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(width/9,0,width/4,0),
                  child: TextFormField(
                    controller: idTextController,
                    validator: (value){
                      if (value == null || value.trim().isEmpty) {
                        return "Enter ID";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: CupertinoColors.white,
                        icon: Icon(CupertinoIcons.search),
                        label: Text("Search",style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 15)),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white54)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.white54)
                        )
                    ),
                  ),
                ),
                SizedBox(height: height/20,),
                ElevatedButton(
                  onPressed: (){
                    if(key.currentState!.validate()){
                       searchBox.setId(idTextController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme().getColor(),
                      fixedSize: Size(height/1.7, width/5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  child: Text("Search",style: GoogleFonts.notoSans(textStyle: TextStyle(fontWeight: FontWeight.bold,color: AppTheme().getHeaderColor(),fontSize: 17)),),
                ),

                if(id.isNotEmpty)
                  Padding(
                    padding:  EdgeInsets.only(top: height/10),
                    child: StudentService(searchBox.getId()),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

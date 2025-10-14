import 'dart:ui';

class AppTheme{
  Color color = Color.fromRGBO(100, 127, 188, 0.1);
  AppTheme();
  Color getColor(){
    return color;
  }
  Color getHeaderColor(){
    return Color.fromRGBO(60, 79, 122, 0.9);
  }
  Color getIconColor(){
    return Color.fromRGBO(60, 79, 122, 0.9);
  }
}
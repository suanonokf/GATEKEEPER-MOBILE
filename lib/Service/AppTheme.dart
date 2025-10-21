import 'dart:ui';

class AppTheme{
  Color color = Color.fromRGBO(175, 204, 255, 0.75);
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
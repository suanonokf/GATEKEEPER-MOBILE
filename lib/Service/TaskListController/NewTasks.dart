import 'dart:convert';

import 'package:http/http.dart' as http;

class NewTasks{
  List<dynamic> tasksList;
  NewTasks(this.tasksList);
  Future<List<dynamic>?> getIncompleteTasks() async {
    try{
      var response = await http.get(
        Uri.parse("Fetch for incomplete tasks"),
      );
       List<dynamic> incompleteTasksLists = jsonDecode(response.body);
       for(var tasks in incompleteTasksLists){
         tasksList.add(tasks);
       }
    }
    catch(error){
      return null;
    }
  }
  int getLength(){
    return tasksList.length;
  }
  String getTitle(){
    return "Title";
  }
}
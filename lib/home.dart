import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:rest_api_practice/jsonmodel.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 List<JsonModel> mydata=[];
  FetchData()async{
    String Url="https://jsonplaceholder.typicode.com/photos";
    var response=await http.get(Uri.parse(Url));
    var jsondata=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map data in jsondata){
        mydata.add(JsonModel.fromJson(data));
      }
      return mydata;
    }
    else{
      return mydata;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

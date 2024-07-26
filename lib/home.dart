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
    var jsondata=jsonDecode(response.body);
    if(response.statusCode==200){
      for(Map<String,dynamic> data in jsondata){
        mydata.add(JsonModel.fromJson(data));
      }
      setState(() {});
      return;
    }
    else{
      return;
    }
  }

  @override
  void initState() {
    FetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice"),
        centerTitle: true,
      ),
      body: FutureBuilder(future: FetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // if(snapshot.connectionState==ConnectionState.active){
        return ListView.builder(itemBuilder: (context, index){
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(mydata[index].thumbnailUrl!),
            ),
            title: Text(mydata[index].title!),
            subtitle: Text(snapshot.connectionState.toString()),
          );
        });
        // else if(snapshot.hasError){
        //   return Text(snapshot.hasError.toString());
        // }
        // else{
        //   return Center(child: CircularProgressIndicator());
        // }
      }),

    );
  }
}

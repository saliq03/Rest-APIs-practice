import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
class Practicepost extends StatefulWidget {
  const Practicepost({super.key});

  @override
  State<Practicepost> createState() => _PracticepostState();
}

class _PracticepostState extends State<Practicepost> {
  TextEditingController EmailController=TextEditingController();
  TextEditingController PasswordController=TextEditingController();
  
  PostDataToServer()async{
    try {
      Response response = await http.post(
          Uri.parse("https://reqres.in/api/login"),
          body: {
            "email": EmailController.text.toString(),
            "password": PasswordController.text.toString()
          });
      print(jsonDecode(response.body));
      if(response.statusCode==200){
        print("account created");
      }
      else{
        print(response.statusCode);
        print('failed');
      }
    }
    catch (e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Post Api"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: EmailController,
                  decoration:InputDecoration(
                    hintText: "Email"
                  )
                ),
                SizedBox(height: 20,),
                TextField(
                    controller: PasswordController,
                    decoration:InputDecoration(
                        hintText: "Password"
                    )
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  PostDataToServer();
                }, child: Text("Signup"))
              ],
        ),
      ),
    );
  }
}

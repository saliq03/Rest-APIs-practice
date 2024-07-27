import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:rest_api_practice/ProductModel.dart';
class ProductShow extends StatefulWidget {
  const ProductShow({super.key});

  @override
  State<ProductShow> createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {

  Future<ProductModel?> FetchProductData()async{
  String Url="https://webhook.site/e00d794d-dcb8-46d2-bf9d-e7914ab41686";
  var response=await http.get(Uri.parse(Url));
  var jsonData=jsonDecode(response.body);
  ProductModel productModel=new ProductModel();
  if(response.statusCode==200){
      productModel=ProductModel.fromJson(jsonData);
      return productModel;
  }
  else{
    return productModel;
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: FutureBuilder(future: FetchProductData(),
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError){
          return Text("error occured");
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
              itemBuilder: (context,index){
            return ListTile(

              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image!),
                  ),
                  Text("  "+snapshot.data!.data![index].title!),
                ],
              ),
              subtitle: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.3,
                child: ListView.builder(itemCount:snapshot.data!.data![index].images!.length ,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,position){
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width*.5,
                    child: Image.network(snapshot.data!.data![index].images![position].url!,height: 200,fit: BoxFit.cover,),
                  );
                }),
              ),
            );
          });
        }
      },),
    );
  }
}

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Uploadimagetoapi extends StatefulWidget {
  const Uploadimagetoapi({super.key});

  @override
  State<Uploadimagetoapi> createState() => _UploadimagetoapiState();
}

class _UploadimagetoapiState extends State<Uploadimagetoapi> {
  File? pickedImage;
  bool Showspinner=false;

  PickImage()async{
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;
      final tempImg = await File(img.path);
      setState(() {
        pickedImage = tempImg;
      });
    }
    catch (e){
      print(e.toString());
    }
  }

  UploadImage()async{
    if(pickedImage!=null){
      setState(() {
        Showspinner=true;
      });
      try {
        print("qwerty");
        var stream = new http.ByteStream(pickedImage!.openRead());
        stream.cast();
        var length = await pickedImage!.length();
        var Url = "https://fakestoreapi.com/products";

        var request = new http.MultipartRequest("POST", Uri.parse(Url));
        request.fields['title'] = "static field";
        var multipart = new http.MultipartFile(
            "image",
            stream,
            length);
        request.files.add(multipart);
        var response = await request.send();
        if (response.statusCode == 200) {
          print("image uploaded");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("image uploaded")));
        }
        else {
          print("fialed");
        }
      }
      catch (e){
        print(e.toString());
      }

      setState(() {
        Showspinner=false;

      });
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image (Post API)"),
      ),

      body: ModalProgressHUD(
        inAsyncCall: Showspinner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                print("image called");
                PickImage();
              },
              child: Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(11)
                ),
                child: pickedImage==null?Center(child: Icon(Icons.camera_alt_outlined)):
                ClipRRect(borderRadius: BorderRadius.circular(11),
                    child: Image.file(pickedImage!,width: 150,height: 200,fit: BoxFit.cover,)),
              ),
            ),
            SizedBox(height: 20,width: MediaQuery.of(context).size.width,),
            ElevatedButton(onPressed: (){
            UploadImage();
            }, child: Text("Upload"))
          ],
        ),
      ),
    );
  }
}

// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uploadimages/personsdata.dart';

void main() {
  runApp(
    MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(),
  ),
  );
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   File imagefile;
  final picker=ImagePicker();
  TextEditingController ctrlname=new TextEditingController();
  bool checkstatus=false;
  int categorystatus;
  String imagedata;
  static const add_category_url="http://192.168.51.104/car_wash/Database/allpersons.php";
  
  Future addCategory() async{
    var data={
      "imgname":ctrlname.text,
      "img":imagedata,
      "imgstatus":categorystatus.toString(),
    };
    var response=await http.post(add_category_url,body: data);
    if(response.statusCode==200){
      print(response.body);
      Fluttertoast.showToast(msg:"Image Added",toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        );
   }
  }
  

   uploadImage()async{
     var pickedimage=await ImagePicker().getImage(source: ImageSource.camera,imageQuality: 25);
     if(pickedimage!=null){
       setState(() {
         imagefile=File(pickedimage.path);
       });
       imagedata=base64Encode(imagefile.readAsBytesSync());
       return imagedata;
     }
     else{
       return null;
     }
   }

   showImage(String image){
      return Image.memory(base64Decode(image),width: 200,height: 400,);
   }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image to database"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => AllImages()), (
                                  route) => false);
          },
           icon: Icon(Icons.list))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: ctrlname,
                  decoration: InputDecoration(labelText: "Name"),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                child: imagedata==null? Text("No Image Selected"):Container(child: showImage(imagedata)),
              ),
              Checkbox(
                value: checkstatus , 
                onChanged: (newvalue){
                  setState(() {
                    checkstatus=newvalue;
                  });
                  if(checkstatus){
                    categorystatus=1;
                  }
                  else{
                    categorystatus=0;
                  }
                  print(categorystatus);
                }),
              ElevatedButton.icon(
                  onPressed: (){
                      addCategory();
                  },
                   icon: Icon(Icons.file_upload),
                  label: Text("Upload Image"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
         uploadImage();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}



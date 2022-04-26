import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uploadimages/main.dart';
class AllImages extends StatefulWidget {

  static const load_category_url="http://192.168.51.104/car_wash/Database/load.php";

  @override
  _AllImagesState createState() => _AllImagesState();
}

class _AllImagesState extends State<AllImages> {
  List categorylist=[];

  Future getAllCategory() async{
     var response=await http.get(AllImages.load_category_url);
    if(response.statusCode==200){
      setState(() {
        categorylist=jsonDecode(response.body);
      });
    }
  }
  showImage(String image){
      return Image.memory(base64Decode(image),width: 100,height: 100,);
   }

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Images"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(Icons.search),
              onTap: (){

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(Icons.add),
              onTap: (){
               Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => MyHomePage()), (
                                  route) => false);
              },
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: categorylist.length,
        itemBuilder: (context,index){
        return Card(
          color: Colors.black,
          child: ListTile(
            title: Text(categorylist[index]["imgname"],style: TextStyle(color: Colors.white),),
            trailing: showImage(categorylist[index]["img"]),
          ),
        );
      }),
    );
  }
}
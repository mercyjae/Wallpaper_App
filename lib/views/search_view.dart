import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../view_model/wallpaper_model.dart';
import '../widgets/brand_name.dart';

class SearchView extends StatefulWidget {
  final String searchData;
  const SearchView({Key? key, required this.searchData}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  List <WallPaperModel> wallpapers = [];
  getSearchPhoto(String data) async {
    final url = "https://api.pexels.com/v1/search?query=$data&per_page=10";
    var response = await http.get(Uri.parse(url),headers: {"Authorization": apiKEY});
   // print(response.body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallPaperModel wallPaperModel = WallPaperModel.fromMap(element);
      wallpapers.add(wallPaperModel);
    });
    setState(() {

    });

  }


  @override
  void initState() {
    super.initState();
    getSearchPhoto(widget.searchData);
   _controller.text = widget.searchData;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      elevation: 0,
      title: BrandName(),centerTitle: true,),
        body:Column(
          children: [
            Container(margin: const EdgeInsets.symmetric(horizontal: 20),
              padding:const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                  color:const Color(0xfff5f8fD)),
              child: Row(children: [
                Expanded(child: TextField(controller: _controller,
                  decoration: const InputDecoration(hintText: "Search",
                    border: InputBorder.none),)
                ),
                IconButton(onPressed: (){
                  getSearchPhoto(_controller.text);

                }, icon: const Icon(Icons.search))
              ],),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: wallPaperList(wallpapers, context),
            ),

          ],
        )
    );
  }
}

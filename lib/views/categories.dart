import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/data.dart';
import '../view_model/wallpaper_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/brand_name.dart';

class Categories extends StatefulWidget {
  final String categoriesName;
  const Categories({Key? key, required this.categoriesName}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final TextEditingController _controller = TextEditingController();
  List<WallPaperModel> wallpapers = [];
  getSearchPhoto(String data) async {
    final url = "https://api.pexels.com/v1/search?query=$data&per_page=10";
    var response =
        await http.get(Uri.parse(url), headers: {"Authorization": apiKEY});
    // print(response.body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      //print(element);
      WallPaperModel wallPaperModel = WallPaperModel.fromMap(element);
      wallpapers.add(wallPaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchPhoto(widget.categoriesName);
    // _controller.text = widget.searchData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: BrandName(),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: wallPaperList(wallpapers, context),
            ),
          ],
        ));
  
  }
}

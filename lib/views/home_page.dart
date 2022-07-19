
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpapers_hub/views/search_view.dart';
import 'package:http/http.dart' as http;
import '../data/data.dart';
import '../view_model/categories_model.dart';
import '../view_model/wallpaper_model.dart';
import '../widgets/brand_name.dart';
import '../widgets/categories_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> categories = [];
  List<WallPaperModel> wallpapers = [];
  final TextEditingController _controller = TextEditingController();

  getTrendingPhotos() async{
    const url = "https://api.pexels.com/v1/curated?per_page=10";
    var response = await http.get(Uri.parse(url),headers: {"Authorization" : apiKEY});
   print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallPaperModel wallPaperModel = WallPaperModel.fromMap(element);
      wallpapers.add(wallPaperModel);
    });
    setState(() {

    });
  }

  void loadCategories() {
    categories = getCategories();
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getTrendingPhotos();
    loadCategories();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.transparent,
      elevation: 0,
      title:  BrandName(),
      centerTitle: true,),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      SearchView(searchData:_controller.text)));

                }, icon: const Icon(Icons.search))

              ],),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 100,
              // child: ListView.builder(itemCount: categories.length,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) => CategoriesTile(imgUrl: categories[index].imgUrl, 
              //     title:categories[index].categoriesName)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...categories.map((category) => CategoriesTile(
                      imgUrl: category.imgUrl,
                      title: category.categoriesName,
                    )).toList(),
                  ]
                ),
              )
            ),
            Expanded(
              child: wallPaperList(wallpapers, context),
            ),
            
          ],
        )
    );
  }
}

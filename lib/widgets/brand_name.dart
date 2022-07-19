

import 'package:flutter/material.dart';

import '../view_model/wallpaper_model.dart';
import '../views/image_view.dart';

Widget BrandName(){
  return
  const Text.rich(TextSpan(
    text: "Wallpaper",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      children: [
      TextSpan(text: "Hub",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
      )
  ]
  ));
  // return Row(mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //   Text("Wallpaper",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
  //   Text("Hub",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
  // ],);
}

Widget wallPaperList(List<WallPaperModel> wallpapers, BuildContext context){
  return GridView.count(crossAxisCount: 2,shrinkWrap: true,physics: const ClampingScrollPhysics(),
    childAspectRatio: 1,padding: const EdgeInsets.symmetric(horizontal: 16),
  mainAxisSpacing: 6,crossAxisSpacing: 4,
   children: wallpapers.map((wallpaper){
   // print("CategoryImage: ${wallpaper.src.portrait}");
    return GridTile(child: GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          ImageView(imgUrl: wallpaper.src.portrait)));
    },
      child: Hero(tag: wallpaper.src.portrait,
        child: ClipRRect(borderRadius: BorderRadius.circular(12),
            child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
      ),
    )
    );
  }).toList());
}

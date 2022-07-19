import 'package:flutter/material.dart';

import '../views/categories.dart';
class CategoriesTile extends StatelessWidget {
 final String imgUrl;
 final String title;
  const CategoriesTile({Key? key, required this.imgUrl, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories(categoriesName: title)));
    },
      child: Container(margin: const EdgeInsets.only(left: 7),
        child:
        Stack(children: [
           Hero(tag: imgUrl,
             child: ClipRRect(borderRadius: BorderRadius.circular(12),
                    child: Image.network(imgUrl,width: 100,height: 80,fit: BoxFit.cover,)),
           ),
          Positioned(top: 35,left: 25,
              child: Text(title,style: const TextStyle(color: Colors.white),)),
        ],),),
    );
  }
}

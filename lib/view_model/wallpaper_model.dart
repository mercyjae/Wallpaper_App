class WallPaperModel{
 final String photographer;
 final String photographerUrl;
final int photographerId;
final SrcModel src;

  WallPaperModel({required this.photographer, required this.photographerUrl,
    required this.photographerId, required this.src});

  factory WallPaperModel.fromMap(Map<String, dynamic> jsonData){
    return WallPaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographer: jsonData["photographer"],
      photographerId: jsonData["photographer_id"],
      photographerUrl: jsonData["photographer_url"],
    );
  }
}

class SrcModel{
  final String original;
  final String small;
  final String portrait;

  SrcModel({required this.original,required this.small, required this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData){
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"]
    );
  }
}
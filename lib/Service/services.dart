import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practical_task_coruscate/Model/Images.dart';

class Services{
  //url of json from where images are to be loaded
  static const String url = "https://fakestoreapi.com/products";

  //to load images from json used Future method
  static Future<List<Images>> getPhotos(int page, String category,
      {bool bySearch = false}) async {
    try {
      //Loading only one page but we can pass more
      //parsing the url with specifying page number and default limit is 100
      final response = await http.get(Uri.parse("$url?page=$page&limit=100"));

      if (response.statusCode == 200) {
        //calling the method to map images
        List<Images> list = parsePhotos(response.body);
        List<Images> mensClothingList = List<Images>();
        if (bySearch) {
          if (category == "All") {
            return list;
          } else {
            list.forEach((element) {
              if (element.category.contains(category.toLowerCase())) {
                mensClothingList.add(element);
              }
            });
            return mensClothingList;
          }
        } else {
          if (category == "All") {
            return list;
          } else {
            list.forEach((element) {
              if (element.category == category) {
                mensClothingList.add(element);
              }
            });
            return mensClothingList;
          }
        }
      }else{
          throw Exception("Error");
          }
      }catch(e){
        print(e); //to print the error occurred during loading of images
      }
  }

  static List<Images> parsePhotos(String responseBody) {
    //decoding json data
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    //parsing and mapping images from json
    return parsed.map<Images>((json)=> Images.fromJson(json)).toList();
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practical_task_coruscate/Images.dart';
import 'package:practical_task_coruscate/services.dart';
import 'Images.dart';
import 'secondpage.dart';
import 'dart:math';
import 'package:http/http.dart' as http;


import 'secondpage.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //declared a variable for page number
  int i;

  ScrollController scrollController=ScrollController(); //for controlling scroller
List<Images> mensClothingList = List<Images>();
List<Images> jeweleryList = List<Images>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mens()async {
      final response = await http.get(
          Uri.parse("${Services.url}?page=1&limit=20"));
      List mensClothing = [];
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      mensClothing =
          parsed.map<Images>((json) => Images.fromJson(json)).toList();
      mensClothing.forEach((element) {
        if (element["category"] == "men's clothing") {
          mensClothingList.add(element);
        }else if (element["category"] == "jewelery") {
          jeweleryList.add(element);
        }
      });
    }
    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent)
        {
          //If we are at the bottom of the page
          //On Scrolling new page with 10 new images will be fetched
          i = Random().nextInt(100);  // for random images we are taking random page
          setState(() {
                //setting the set so that on scrolling new pages should appear
          });
        }
    });
  }

  @override
  void dispose(){
    scrollController.dispose();  //to clear the memory occupied
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  //to remove the dubug mode banner
      theme: ThemeData(
        primaryColor: Colors.black, //we can also use dynamic_theme or dark mode for design
      ),
      home: DefaultTabController(length: 5,
        child: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            title: Text("Image"),bottom:
            TabBar(isScrollable: true,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Men's Cloth"),
                Tab(text: "Jewelery"),
                Tab(text: "Women's Cloth"),
                Tab(text: "Electronics"),
              ],
            ),
          ),
          body: TabBarView(
            children:[ Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: FutureBuilder<List<Images>>(
                    future: Services.getPhotos(i,"All"),  //fetching images from json by passing random page number
                    builder: (context,snapshot){
                      if(snapshot.hasError)
                      {
                        return Text('Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                      }
                      if(snapshot.hasData){
                        return Padding(
                          padding: EdgeInsets.all(5.0),
                          child: GridView.count(          //grid view for showing 2 column containing images
                            controller: scrollController, //for controlling the scroller
                            crossAxisCount: 2,            //for two column in single row
                            childAspectRatio: 1.0,      //width by height ratio
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            children: snapshot.data.map((images){
                              return GridTile(
                                child: secondPage(images),   //calling another page in which single images decoration is implemented
                              );
                            },).toList(),
                          ),
                        );

                      }
                      return Center(child: CircularProgressIndicator(),);   //to show progess bar uptill datas are not fetched
                    },
                  ),
                )
              ],
            ),Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: FutureBuilder<List<Images>>(
                    future: Services.getPhotos(i,"men's clothing"),  //fetching images from json by passing random page number
                    builder: (context,snapshot){
                      if(snapshot.hasError)
                        {
                          return Text('Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                        }
                      if(snapshot.hasData){
                        return Padding(
                          padding: EdgeInsets.all(5.0),
                          child: GridView.count(          //grid view for showing 2 column containing images
                            controller: scrollController, //for controlling the scroller
                            crossAxisCount: 2,            //for two column in single row
                            childAspectRatio: 1.0,      //width by height ratio
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            children: snapshot.data.map((images){
                              return GridTile(
                                child: secondPage(images),   //calling another page in which single images decoration is implemented
                              );
                            },).toList(),
                          ),
                        );

                      }
                      return Center(child: CircularProgressIndicator(),);   //to show progess bar uptill datas are not fetched
                    },
                  ),
                )
              ],
            ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: FutureBuilder<List<Images>>(
                      future: Services.getPhotos(i,"jewelery"),  //fetching images from json by passing random page number
                      builder: (context,snapshot){
                        if(snapshot.hasError)
                        {
                          return Text('Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                        }
                        if(snapshot.hasData){
                          return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: GridView.count(          //grid view for showing 2 column containing images
                              controller: scrollController, //for controlling the scroller
                              crossAxisCount: 2,            //for two column in single row
                              childAspectRatio: 1.0,      //width by height ratio
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              children: snapshot.data.map((images){
                                return GridTile(
                                  child: secondPage(images),   //calling another page in which single images decoration is implemented
                                );
                              },).toList(),
                            ),
                          );

                        }
                        return Center(child: CircularProgressIndicator(),);   //to show progess bar uptill datas are not fetched
                      },
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: FutureBuilder<List<Images>>(
                      future: Services.getPhotos(i,"women's clothing"),  //fetching images from json by passing random page number
                      builder: (context,snapshot){
                        if(snapshot.hasError)
                        {
                          return Text('Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                        }
                        if(snapshot.hasData){
                          return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: GridView.count(          //grid view for showing 2 column containing images
                              controller: scrollController, //for controlling the scroller
                              crossAxisCount: 2,            //for two column in single row
                              childAspectRatio: 1.0,      //width by height ratio
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              children: snapshot.data.map((images){
                                return GridTile(
                                  child: secondPage(images),   //calling another page in which single images decoration is implemented
                                );
                              },).toList(),
                            ),
                          );

                        }
                        return Center(child: CircularProgressIndicator(),);   //to show progess bar uptill datas are not fetched
                      },
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: FutureBuilder<List<Images>>(
                      future: Services.getPhotos(i,"electronics"),  //fetching images from json by passing random page number
                      builder: (context,snapshot){
                        if(snapshot.hasError)
                        {
                          return Text('Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                        }
                        if(snapshot.hasData){
                          return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: GridView.count(          //grid view for showing 2 column containing images
                              controller: scrollController, //for controlling the scroller
                              crossAxisCount: 2,            //for two column in single row
                              childAspectRatio: 1.0,      //width by height ratio
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              children: snapshot.data.map((images){
                                return GridTile(
                                  child: secondPage(images),   //calling another page in which single images decoration is implemented
                                );
                              },).toList(),
                            ),
                          );

                        }
                        return Center(child: CircularProgressIndicator(),);   //to show progess bar uptill datas are not fetched
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

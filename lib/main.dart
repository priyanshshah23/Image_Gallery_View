import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practical_task_coruscate/Model/Images.dart';
import 'package:practical_task_coruscate/Service/services.dart';
import 'Model/Images.dart';
import 'galleryPage.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //declared a variable for page number
  int i;

  ScrollController scrollController =
      ScrollController(); //for controlling scroller
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Initially as per task load only one page.
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //If we are at the bottom of the page
        //On Scrolling new page with 10 new images will be fetched
        i = Random()
            .nextInt(100); // for random images we are taking random page
        setState(() {
          //setting the set so that on scrolling new pages should appear
        });
      }
    });
    print("InitState");
  }

  @override
  void dispose() {
    scrollController.dispose(); //to clear the memory occupied
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //to remove the dubug mode banner
      theme: ThemeData(
        primaryColor: Colors
            .black, //we can also use dynamic_theme or dark mode for design
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            title: Text("Image Gallery"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Men's Cloth"),
                Tab(text: "Jewelery"),
                Tab(text: "Women's Cloth"),
                Tab(text: "Electronics"),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        getSearchTextField(),
                        const SizedBox(
                          height: 20,
                        ),
                        _searchController.text.isNotEmpty
                            ? Flexible(
                                child: FutureBuilder<List<Images>>(
                                  future: Services.getPhotos(
                                      i, _searchController.text,
                                      bySearch: true),
                                  //fetching images from json by passing random page number
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print("nnnn");
                                      return Center(
                                          child: Text(
                                              "No Record Found")); //if there is error in fetching data then this condition will be performed
                                    }
                                    if (snapshot.hasData) {
                                      print(snapshot.data.length);
                                      return snapshot.data.length != 0
                                          ? Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: GridView.count(
                                                //grid view for showing 2 column containing images
                                                controller: scrollController,
                                                //for controlling the scroller
                                                crossAxisCount: 3,
                                                //for two column in single row
                                                childAspectRatio: 1.0,
                                                //width by height ratio
                                                mainAxisSpacing: 4.0,
                                                crossAxisSpacing: 4.0,
                                                children: snapshot.data.map(
                                                  (images) {
                                                    return GridTile(
                                                      child: galleryPage(
                                                          images), //calling another page in which single images decoration is implemented
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                              "No Record Found",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: (16),
                                              ),
                                            ));
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    ); //to show progess bar uptill datas are not fetched
                                  },
                                ),
                              )
                            : Flexible(
                                child: FutureBuilder<List<Images>>(
                                  future: Services.getPhotos(i, "All"),
                                  //fetching images from json by passing random page number
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                          'Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                                    }
                                    if (snapshot.hasData) {
                                      return Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: GridView.count(
                                          //grid view for showing 2 column containing images
                                          controller: scrollController,
                                          //for controlling the scroller
                                          crossAxisCount: 3,
                                          //for two column in single row
                                          childAspectRatio: 1.0,
                                          //width by height ratio
                                          mainAxisSpacing: 4.0,
                                          crossAxisSpacing: 4.0,
                                          children: snapshot.data.map(
                                            (images) {
                                              return GridTile(
                                                child: galleryPage(
                                                    images), //calling another page in which single images decoration is implemented
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    ); //to show progess bar uptill datas are not fetched
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
                            future: Services.getPhotos(i, "men's clothing"),
                            //fetching images from json by passing random page number
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                              }
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: GridView.count(
                                    //grid view for showing 2 column containing images
                                    controller: scrollController,
                                    //for controlling the scroller
                                    crossAxisCount: 3,
                                    //for two column in single row
                                    childAspectRatio: 1.0,
                                    //width by height ratio
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: snapshot.data.map(
                                      (images) {
                                        return GridTile(
                                          child: galleryPage(
                                              images), //calling another page in which single images decoration is implemented
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              ); //to show progess bar uptill datas are not fetched
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
                            future: Services.getPhotos(i, "jewelery"),
                            //fetching images from json by passing random page number
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                              }
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: GridView.count(
                                    //grid view for showing 2 column containing images
                                    controller: scrollController,
                                    //for controlling the scroller
                                    crossAxisCount: 3,
                                    //for two column in single row
                                    childAspectRatio: 1.0,
                                    //width by height ratio
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: snapshot.data.map(
                                      (images) {
                                        return GridTile(
                                          child: galleryPage(
                                              images), //calling another page in which single images decoration is implemented
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              ); //to show progess bar uptill datas are not fetched
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
                            future: Services.getPhotos(i, "women's clothing"),
                            //fetching images from json by passing random page number
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                              }
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: GridView.count(
                                    //grid view for showing 2 column containing images
                                    controller: scrollController,
                                    //for controlling the scroller
                                    crossAxisCount: 3,
                                    //for two column in single row
                                    childAspectRatio: 1.0,
                                    //width by height ratio
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: snapshot.data.map(
                                      (images) {
                                        return GridTile(
                                          child: galleryPage(
                                              images), //calling another page in which single images decoration is implemented
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              ); //to show progess bar uptill datas are not fetched
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
                            future: Services.getPhotos(i, "electronics"),
                            //fetching images from json by passing random page number
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Error ${snapshot.error}'); //if there is error in fetching data then this condition will be performed
                              }
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: GridView.count(
                                    //grid view for showing 2 column containing images
                                    controller: scrollController,
                                    //for controlling the scroller
                                    crossAxisCount: 3,
                                    //for two column in single row
                                    childAspectRatio: 1.0,
                                    //width by height ratio
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: snapshot.data.map(
                                      (images) {
                                        return GridTile(
                                          child: galleryPage(
                                              images), //calling another page in which single images decoration is implemented
                                        );
                                      },
                                    ).toList(),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              ); //to show progess bar uptill datas are not fetched
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSearchTextField() {
    return Hero(
      tag: 'searchTextField',
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            left: (20),
            right: (20),
          ),
          child: Container(
//            height: getSize(40),
            child: TextFormField(
              minLines: 1,
              textAlignVertical: TextAlignVertical(y: 1.0),
              textInputAction: TextInputAction.search,
              autofocus: false,
              controller: _searchController,
              obscureText: false,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              onFieldSubmitted: (value) {
                _searchController.text = value;
                FocusScope.of(context).unfocus();
                setState(() {});
              },
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search",
                labelStyle: TextStyle(
                  color: Colors.red,
                  fontSize: (16),
                ),
                // suffix: widget.textOption.postfixWidOnFocus,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all((10)),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

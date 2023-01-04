import 'package:file/src/interface/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';


void main(){
  runApp(MaterialApp(home:Home() ,));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    get();
  }
  get() async {
    File file = await DefaultCacheManager().getSingleFile("url");
  }

  List<String> imgList = [
    "assets/images/sagar.jpg",
    "assets/images/sagar.jpg",
    "assets/images/sagar.jpg",
    "assets/images/sagar.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whallpaper"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("second"),
                    ),
                    body: Image.asset("${imgList[index]}"),
                    floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          int location = WallpaperManager.BOTH_SCREEN;
                          var file = await DefaultCacheManager().getSingleFile(AutofillHints.photo);

                          bool result =
                          await WallpaperManager.setWallpaperFromFile(
                              file.path, location); //provide image path
                        },
                        child: Icon(Icons.download)),
                  );
                },
              ));
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Image.asset("${imgList[index]}");
              },
            ),
          );
        },
      ),
    );
  }
}

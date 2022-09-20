import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wingstop/homedetail.dart';
import 'package:wingstop/itemlist.dart';
import 'package:wingstop/login.dart';
import 'package:wingstop/theme.dart';

class HomePage extends StatelessWidget {
  String email;
  HomePage({super.key, required this.email});

  var images = ["assets/cs1.png", "assets/cs2.jpg", "assets/cs3.jpg"];
  var details = [
    HomeDetail(
      image: "assets/1.jpg", 
      heading: "Free Refill Promo", 
      description: "You can refill Wings, Sides, Rices, and Drinks, Enjoy Free Refill Promo until you satisfied while it last"
    ),
    HomeDetail(
      image: "assets/2.jpg", 
      heading: "8.8 Wings Promo", 
      description: "Buy 8 Crunchy Wings ALL FLAVORS to get 8 FREE Boneless Wings for only Rp80.000"
    ),
    HomeDetail(
      image: "assets/3.jpg", 
      heading: "GoFood Promo", 
      description: "Enjoy our GoFood Promo where You can get FREE 20 Boneless Wings with purchase of 20 Crunchy Wings."
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: PopupMenuButton(
              child: const Center(child: Icon(Icons.more_vert)),
              itemBuilder:(context) {
                return List.generate(
                  1, 
                  (index) => (PopupMenuItem(
                    child: const Text("Toggle Light/Dark Theme"),
                    onTap: () {
                      ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                      themeProvider.changeTheme();
                    },
                  )));
              },
            )
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text(email)),
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return HomePage(email: email);
                  },), (route) => false);
              },
            ),
            ListTile(
              title: const Text("Our Food List"),
              onTap: (() {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return ItemListPage(email: email);
                  },), (route) => false);
              }),
            ),
            ListTile(
              title: const Text("Log Out"),
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },), (route) => false);
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: images.map((e) => Image.asset(e)).toList(), 
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2)
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    children: [
                      const LinearProgressIndicator(),
                      Image.asset(details[index].image),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 3),
                        child: Text(
                          details[index].heading,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 24
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 3, 5, 10),
                        child: Text(
                          "${details[index].description}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            height: 1,
                            fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const LinearProgressIndicator(),
                    ],
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }
}
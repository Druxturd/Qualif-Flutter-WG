import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wingstop/detail.dart';
import 'package:wingstop/home.dart';
import 'package:wingstop/item.dart';
import 'package:wingstop/login.dart';
import 'package:wingstop/theme.dart';

class ItemListPage extends StatelessWidget {
  String email;
  ItemListPage({super.key, required this.email});

  var itemList = [
    Item(
      image: "assets/i1.jpg", 
      name: "Crunchy Chicken Wings", 
      description: "10 pcs of Crunchy Chicken Wings", 
      price: "Rp55.000"
    ),
    Item(
      image: "assets/i2.jpg", 
      name: "Garlic Pepper Chicken Wings", 
      description: "10 pcs of Garlic Pepper Chicken Wings", 
      price: "Rp72.500" 
    ),
    Item(
      image: "assets/i3.jpg", 
      name: "All In Bundle", 
      description: "40 pcs of your chosen flavor chicken wings with mayonnaise sauce, french fries, and salad to complete the wings", 
      price: "Rp225.000"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Food List"),
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
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Expanded(
          child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(itemList[index].image),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      itemList[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1,
                        fontSize: 24
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                    itemList[index].description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        height: 1,
                        fontSize: 20
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      itemList[index].price,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        height: 1,
                        fontSize: 18
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(item: itemList[index], email: email);
                          },
                        ));
                      },
                      child: const Text("View Detail"),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
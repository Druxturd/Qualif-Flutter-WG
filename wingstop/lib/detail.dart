import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wingstop/comment.dart';
import 'package:wingstop/item.dart';
import 'package:wingstop/theme.dart';

class DetailPage extends StatefulWidget {
  Item item;
  String email;
  DetailPage({super.key, required this.item, required this.email});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  TextEditingController commentController = TextEditingController();

  var comments = [
    Comment(email: "bombom@gmail.com", comment: "Best Wings in the world"),
    Comment(email: "DUARDUAR@gmail.com", comment: "The price is reasonable"),
    Comment(email: "debora@gmail.com", comment: "Just perfect 10/10")
  ];

  void handleComment() {
    String comment = commentController.text;

    if(comment == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Comment can not be empty!"))
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Successfully comment!"))
    );
    comments.add(Comment(email: widget.email, comment: comment));
    setState(() {

    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food Details"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.comment))
            ]
          ),
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
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Image.asset(
                    widget.item.image,
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      widget.item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1,
                        fontSize: 20
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                    widget.item.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        height: 1,
                        fontSize: 18
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      widget.item.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        height: 1,
                        fontSize: 18
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Comment"
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: handleComment, child: const Text("Post Comment"))
                ]
              )
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            comments[index].email,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1,
                              fontSize: 20
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            "${comments[index].comment}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              height: 1,
                              fontSize: 18
                            ),
                          ),
                        )
                      ],
                    );
                  },
                )
              ),
            )
          ],
        ),
      )
    );
  }
}
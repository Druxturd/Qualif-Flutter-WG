import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wingstop/login.dart';
import 'package:wingstop/theme.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
    child: const Wingstop(),
    create: (context) => ThemeProvider(isDark: false),
  ));
}

class Wingstop extends StatefulWidget {
  const Wingstop({super.key});

  @override
  State<Wingstop> createState() => _WingstopState();
}

class _WingstopState extends State<Wingstop> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, ThemeProvider, child) {
        return MaterialApp(
          title: "Wingstop",
          theme: ThemeProvider.getTheme,
          home: LoginPage(),
        );
      },
    );
  }
}
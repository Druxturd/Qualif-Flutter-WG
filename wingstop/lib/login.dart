import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wingstop/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAgree = false;

  void handleLogin() {
    String email = emailController.text;
    String password = passwordController.text;
    String msg = "";

    if(email == "" || password == "") {
      msg = "All fields must be filled";
    } else if(!email.endsWith("@gmail.com")) {
      msg = "Email must ends with @gmail.com";
    } else if(password.length < 5) {
      msg = "Password length must more than or equal 5 characters";
    } else if(!isAgree) {
      msg = "Agree to Terms & Conditions must be checked";
    }

    if(msg != "") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                child: const Text("Ok")
              )
            ],
          );
        },
      );
      return;
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return HomePage(email: emailController.text);
    },), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wingstop"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset("assets/logo.png", height: 300, width: 600,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                  ),
                ),
              ),
              CheckboxListTile(
                title: const Text("Agree to Terms & Conditions"),
                value: isAgree, 
                onChanged: (value) {
                  setState(() {
                    isAgree = value!;
                  });
                }
              ),
              ElevatedButton(onPressed: handleLogin, child: const Text("Log In"))              
            ],
          ),
        )
      ),
    );
  }
}
import 'package:client/introduction_screen.dart';
import 'package:client/pages/entry_page.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/signup_page.dart';
import 'package:client/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool show = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true;
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Widget page = HomeScreen();
  final storage = FlutterSecureStorage();
  bool authenticate = false;
  void checkLogin() async{
    String token = await storage.read(key: "token");
    if(token!= null){
      setState(() {
        authenticate = true;
        page=EntryPage();
      });
    }else{
      authenticate=false;
      page=HomeScreen();
    }   
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        
      ),
      home: show && !authenticate ? IntroScreen() : page
      //show && !authenticate ? IntroScreen() : page
    );
  }
}

//


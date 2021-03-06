import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetWorkHandler{
String baseUrl = "http://192.168.1.52:3000/";
var log = Logger();
FlutterSecureStorage storage = FlutterSecureStorage();

 Future<http.Response> post(String url, Map<String, String> body)async{
   //String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
 }

 String formater(url){
    return baseUrl+url;
  }

  Future get(String url)async{
    //user register
   //String token = await storage.read(key: "token");

   url=formater(url);
   var response = await http.get(Uri.parse(url),
   //headers: {"Authorization":"Bearer $token"},
   );
   if(response.statusCode==200 || response.statusCode==201){
      log.i(response.body);
      return json.decode(response.body);
    }

   log.i(response.body);
   log.i(response.statusCode);
  }


  Future<http.Response> getAnnonces(String url)async{
    //user register
    String token = await storage.read(key: "token");

   url=formater(url);
   var response = await http.get(Uri.parse(url),
   headers: {"Authorization":"Bearer $token"},
   );
   if(response.statusCode==200 || response.statusCode==201){
      log.i(response.body);
      //return json.decode(response.body);
    }

   log.i(response.body);
   log.i(response.statusCode);
   return response;
  }


  NetworkImage getImage(String id){
    String url = formater("uploads//$id.jpg");
    return NetworkImage(url);
  }

  NetworkImage getImage1(String username){
    String url = formater("uploads/$username.jpg");
    return NetworkImage(url);
  }


  Future<http.Response> post1(String url, var body) async {
    //String token = await storage.read(key: "token");
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json","Authorization":"Bearer $token"},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url,String filepath)async{
    url = formater(url);
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH',Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type":"multipart/form-data",
      "Authorization":"Bearer $token"
    });
    var response=request.send();
    return response;
  }

  

}


import 'package:json_annotation/json_annotation.dart';


//part 'AddAnnonceModel.g.dart';

class AddAnnonceModel{
  String coverImage;
  String contact;
  bool classee;
  String username;
  String title;
  String description;
  DateTime created_at;
  @JsonKey(name:"_id")
  String id;

  AddAnnonceModel({
    required
    this.coverImage,
    required
    this.contact,
    required
    this.classee,
    required
    this.username,
    required
    this.description,
    required
    this.created_at,
    required
    this.id,
    required
    this.title
  });

  
}
// Importing necessary Dart and Hive packages.
// 'dart:typed_data' is used here to handle binary data for the image (Uint8List).
// Hive is a lightweight and fast key-value database written in pure Dart, used for local data storage.
// The part directive links to the generated adapter code for Hive serialization.
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'undertone_model.g.dart';
@HiveType(typeId: 0)
class UndertoneModel extends HiveObject{
  @HiveField(0)
  final String season;
  @HiveField(1)
  final Uint8List? image;

  UndertoneModel({required this.season , this.image});
}
import 'package:flutter/material.dart';

class Recipe{

  late String title;
  late String type;
  late List<String> ingredients;
  late Image image;
  late List<Map<String, int>> steps;

  Recipe({
    required this.title,
    required this.type,
    required this.ingredients,
    required this.image,
    required this.steps,
  });
}
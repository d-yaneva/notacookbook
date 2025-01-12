import 'package:flutter/material.dart';
import 'package:notacookbook/features/recipe_model.dart';

List<Recipe> recipes = [
  Recipe(
    title: "Apple Pie",
    type: "Dessert",
    ingredients: [
      "2 1/2 cups all-purpose flour",
      "1 cup unsalted butter",
      "1/4 cup ice water",
      "6 medium apples",
      "3/4 cup sugar",
      "1 tsp cinnamon",
      "1/4 tsp nutmeg",
      "1 tbsp lemon juice",
      "1 tbsp cornstarch"
    ],
    image: Image.asset('assets/images/apple_pie.jpg'),
    steps: [
      {"Prepare pie crust by mixing flour, butter, and water": 20},
      {"Chill the dough in the refrigerator": 30},
      {"Peel, core, and slice apples": 10},
      {"Mix apples with sugar, spices, lemon juice, and cornstarch": 5},
      {"Roll out dough and line pie dish": 10},
      {"Add apple filling and cover with top crust": 10},
      {"Bake in a preheated oven at 375°F (190°C)": 50},
    ],
  ),
  Recipe(
    title: "Barbecue Ribs",
    type: "Main Course",
    ingredients: [
      "1 rack of pork ribs",
      "1/4 cup brown sugar",
      "1 tbsp smoked paprika",
      "1 tsp garlic powder",
      "1 tsp onion powder",
      "1 tsp salt",
      "1/2 tsp black pepper",
      "1 cup barbecue sauce"
    ],
    image: Image.asset('assets/images/barbecue_ribs.jpg'),
    steps: [
      {"Remove membrane from ribs and season with dry rub": 15},
      {"Wrap ribs in foil and bake at 300°F (150°C)": 120},
      {"Unwrap ribs and brush with barbecue sauce": 5},
      {"Grill ribs on medium heat to caramelize sauce": 10},
    ],
  ),
  Recipe(
    title: "Baklava",
    type: "Dessert",
    ingredients: [
      "1 package phyllo dough",
      "2 cups chopped walnuts",
      "1 cup melted butter",
      "1 tsp cinnamon",
      "1 cup sugar",
      "1/2 cup water",
      "1/4 cup honey",
      "1 tsp vanilla extract",
      "1/2 lemon (juice)"
    ],
    image: Image.asset('assets/images/baklava.jpg'),
    steps: [
      {"Preheat oven to 350°F (175°C)": 5},
      {"Layer phyllo dough with butter in a baking dish": 15},
      {"Mix walnuts with cinnamon and sprinkle between layers": 10},
      {"Cut into diamond shapes before baking": 5},
      {"Bake until golden brown": 50},
      {"Prepare syrup with sugar, water, honey, and lemon juice": 10},
      {"Pour cooled syrup over hot baklava": 5},
    ],
  ),
];

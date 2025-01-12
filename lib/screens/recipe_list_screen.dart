import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notacookbook/features/recipe_list.dart';
import 'package:notacookbook/features/recipe_model.dart';

class RecipeListScreen extends StatefulWidget {
  final String type;

  const RecipeListScreen({super.key, required this.type});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late String selectedType;
  late List<Recipe> filteredRecipes; // Use Recipe objects
  late List<Recipe> allRecipes;

  @override
  void initState() {
    super.initState();
    selectedType = widget.type;
    allRecipes = getRecipes();
    filteredRecipes = filterRecipesByType(selectedType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$selectedType Recipes',
          style: GoogleFonts.lilyScriptOne(fontSize: 35),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(100, 250, 237, 205),
        child: Column(
          children: [   
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search Recipes',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                style: GoogleFonts.lilyScriptOne(),
                onChanged: (query) {
                  setState(() {
                    filteredRecipes = filterRecipesByQuery(query);
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedType = 'All Recipes';
                      filteredRecipes = allRecipes;
                    });
                  },
                  child: Text(
                    'All Recipes',
                    style: GoogleFonts.lilyScriptOne(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedType = 'Main Course';
                      filteredRecipes = filterRecipesByType('Main Course');
                    });
                  },
                  child: Text(
                    'Main Course',
                    style: GoogleFonts.lilyScriptOne(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedType = 'Dessert';
                      filteredRecipes = filterRecipesByType('Dessert');
                    });
                  },
                  child: Text(
                    'Dessert',
                    style: GoogleFonts.lilyScriptOne(color: Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    title: filteredRecipes[index].title,
                    image: filteredRecipes[index].image,
                    description: 'Description here', // Update description if needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Recipe> getRecipes() {
    return recipes;
  }

  List<Recipe> filterRecipesByType(String type) {
    return allRecipes.where((recipe) => recipe.type == type).toList();
  }

  List<Recipe> filterRecipesByQuery(String query) {
    return allRecipes
        .where((recipe) =>
            recipe.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
class RecipeCard extends StatelessWidget {
  final String title;
  final String image;  // Now this is the image path
  final String description;

  const RecipeCard({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image.asset(
          image,  // Use the image path here
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: GoogleFonts.lilyScriptOne(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.lilyScriptOne(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          // Handle recipe card tap
        },
      ),
    );
  }
}

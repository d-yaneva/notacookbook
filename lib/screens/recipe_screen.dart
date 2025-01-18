import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notacookbook/features/recipe_model.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late List<bool> checkedIngredients;

  @override
  void initState() {
    super.initState();
    checkedIngredients = List<bool>.filled(widget.recipe.ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCD5AE),
      appBar: AppBar(
        title: Text(
          widget.recipe.title,
          style: GoogleFonts.lilyScriptOne(),
        ),
        backgroundColor: const Color(0xFFCCD5AE),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Image.asset(widget.recipe.image, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${widget.recipe.type}', style: GoogleFonts.lilyScriptOne(fontSize: 18)),
                  Text('Servings: ${widget.recipe.servings}', style: GoogleFonts.lilyScriptOne(fontSize: 18)),
                  Text('Total Time: ${widget.recipe.totaltime}', style: GoogleFonts.lilyScriptOne(fontSize: 18)),
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              labelStyle: GoogleFonts.lilyScriptOne(),
              tabs: const [
                Tab(text: 'Ingredients'),
                Tab(text: 'Steps'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: widget.recipe.ingredients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.recipe.ingredients[index],
                                  style: GoogleFonts.lilyScriptOne(),
                                ),
                              ),
                              Checkbox(
                                value: checkedIngredients[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkedIngredients[index] = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: const Color(0xFFE7E7E7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: widget.recipe.steps.length,
                        itemBuilder: (context, index) {
                          String stepText = widget.recipe.steps[index].keys.first;
                          int stepNumber = widget.recipe.steps[index].values.first;
                          return ListTile(
                            title: Text(
                              'Step $stepNumber: $stepText',
                              style: GoogleFonts.lilyScriptOne(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

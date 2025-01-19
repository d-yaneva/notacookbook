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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image section with padding
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    widget.recipe.image,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),

                // Expanded column for text
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${widget.recipe.type}', style: GoogleFonts.lilyScriptOne(fontSize: 14)),
                        Text('Servings: ${widget.recipe.servings}', style: GoogleFonts.lilyScriptOne(fontSize: 14)),
                        Text('Total Time: ${widget.recipe.totaltime}', style: GoogleFonts.lilyScriptOne(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // TabBar for Ingredients and Steps
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: const Color.fromARGB(137, 73, 73, 73),
              labelStyle: GoogleFonts.lilyScriptOne(),
              tabs: const [
                Tab(text: 'Ingredients'),
                Tab(text: 'Steps'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Ingredients tab
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                activeColor: Colors.white, 
                                checkColor: Colors.black,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Steps tab with numbered circles
                  Container(
                    color: const Color(0xFFE7E7E7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: widget.recipe.steps.length,
                        itemBuilder: (context, index) {
                          String stepText = widget.recipe.steps[index].keys.first;
                          return ListTile(
                            leading: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black, // Adjust color as needed
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}', // Step number
                                style: GoogleFonts.lilyScriptOne(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(
                              stepText,
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

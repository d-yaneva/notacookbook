import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:notacookbook/features/recipe_list.dart';
import 'package:notacookbook/features/recipe_model.dart';
import 'package:notacookbook/screens/recipe_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GetFoodScreen extends StatefulWidget {
  const GetFoodScreen({super.key, required this.title});
  final String title;

  @override
  State<GetFoodScreen> createState() => _GetFoodScreennState();
}

class _GetFoodScreennState extends State<GetFoodScreen> {
  File? image;
  late ImagePicker imagePicker;
  late ImageLabeler labeler;
  String results = "";
  Recipe? matchedRecipe;

  Recipe? getRecipe(String food) {
    for (var recipe in recipes) {
      if (recipe.title.toLowerCase() == food.toLowerCase()) {
        return recipe;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    loadModel();
  }

  loadModel() async {
    final modelPath = await getModelPath('assets/foods.tflite');
    final options = LocalLabelerOptions(
      confidenceThreshold: 0.7,
      modelPath: modelPath,
    );
    labeler = ImageLabeler(options: options);
  }

  chooseImage() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      image = File(selectedImage.path);
      performImageLabeling();
      setState(() {
        image;
      });
    }
  }

  captureImage() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      image = File(selectedImage.path);
      performImageLabeling();
      setState(() {
        image;
      });
    }
  }

  performImageLabeling() async {
    results = "";
    matchedRecipe = null;

    if (image == null) {
      print("No image selected for labeling.");
      return;
    }

    InputImage inputImage = InputImage.fromFile(image!);
    final List<ImageLabel> labels = await labeler.processImage(inputImage);

    if (labels.isEmpty) {
      print("No labels detected.");
    } else {
      print("Detected labels:");
    }

    for (ImageLabel label in labels) {
      final String originalText = label.label; // Original detected label
      final String cleanedText =
          originalText.replaceAll(RegExp(r'[0-9]'), '').trim(); // Remove numbers
      final double confidence = label.confidence;

      print("Original: $originalText, Cleaned: $cleanedText (${confidence.toStringAsFixed(2)})");

      results += "$cleanedText (${confidence.toStringAsFixed(2)})\n";

      matchedRecipe = getRecipe(cleanedText);
      if (matchedRecipe != null) {
        print("Match found! Recipe: ${matchedRecipe!.title}");
        break; // Stop searching after the first match
      } else {
        print("No match found for: $cleanedText");
      }
    }

    if (matchedRecipe == null) {
      print("No recipe matched any of the detected labels.");
      print("Available recipes in the list:");
      for (var recipe in recipes) {
        print(" - ${recipe.title}");
      }
    }

    setState(() {});
  }

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFFCCD5AE), // AppBar color
      title: Text(widget.title),
    ),
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              color: const Color(0xFFE9EDC9), // Background color
              child: image == null
                  ? const Icon(Icons.image_outlined, size: 58)
                  : Image.file(image!),
            ),
            ElevatedButton(
              onPressed: chooseImage,
              onLongPress: captureImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCD5AE), // Button color
              ),
              child: const Text('Choose or hold to capture'),
            ),
            Card(
              color: const Color(0xFFFEFAE0), // Text container color
              margin: const EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      results.isEmpty
                          ? "No food detected"
                          : "$results",
                      style: const TextStyle(fontSize: 18),
                    ),
                    if (matchedRecipe != null) ...[
                      Text(
                        "\nRecipe: ${matchedRecipe!.title}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeScreen(recipe: matchedRecipe!),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCCD5AE),
                        ),
                        child: const Text('View Recipe'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

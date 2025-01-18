import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:notacookbook/features/recipe_list.dart';
import 'package:notacookbook/features/recipe_model.dart';
import 'package:notacookbook/screens/recipe_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not a Cookbook',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFFEFAE0), // Background color
        textTheme: GoogleFonts.lilyScriptOneTextTheme(
          Theme.of(context).textTheme, 
        ),
      ),
      home: const GetFoodScreen(title: 'Food Detector'),
    );
  }
}

class GetFoodScreen extends StatefulWidget {
  const GetFoodScreen({super.key, required this.title});
  final String title;

  @override
  State<GetFoodScreen> createState() => _GetFoodScreenState();
}

class _GetFoodScreenState extends State<GetFoodScreen> {
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
    setState(() {
      results = "No image selected for labeling.";
    });
    return;
  }

  InputImage inputImage = InputImage.fromFile(image!);

  //generic model
  final genericLabeler = ImageLabeler(options: ImageLabelerOptions());
  final List<ImageLabel> genericLabels = await genericLabeler.processImage(inputImage);
  genericLabeler.close();

  bool isFoodDetected = false;
  String detectedObject = "";

  for (ImageLabel label in genericLabels) {
    String cleanedText = label.label.toLowerCase();
    

    if (cleanedText.contains("animal") || cleanedText.contains("dog") || cleanedText.contains("cat")) {
      setState(() {
        results = "That's not food, that's an animal.";
      });
      return;
    }

    if (cleanedText.contains("object") || cleanedText.contains("furniture") || cleanedText.contains("tool")) {
      setState(() {
        results = "That's not food, that's an object.";
      });
      return;
    }

    if (cleanedText.contains("food") || cleanedText.contains("dish") || 
        cleanedText.contains("meal") || cleanedText.contains("cuisine") || 
        cleanedText.contains("snack") || cleanedText.contains("fruit") || 
        cleanedText.contains("vegetable")) {
      isFoodDetected = true;
      detectedObject = cleanedText;
    }
  }

  if (!isFoodDetected) {
    setState(() {
      results = "No food detected.";
    });
    return;
  }

  //custom model
  final customLabeler = ImageLabeler(
    options: LocalLabelerOptions(
      confidenceThreshold: 0.7,
      modelPath: await getModelPath('assets/foods.tflite'),
    ),
  );

  final List<ImageLabel> customLabels = await customLabeler.processImage(inputImage);
  customLabeler.close();

  bool foundFoodInCustomModel = false;

  for (ImageLabel label in customLabels) {
    final String cleanedText = label.label.replaceAll(RegExp(r'[0-9]'), '').trim();
    results += "$cleanedText ";

    matchedRecipe = getRecipe(cleanedText);
    if (matchedRecipe != null) {
      foundFoodInCustomModel = true;
      break;
    }
  }

  if (!foundFoodInCustomModel) {
    setState(() {
      results = "This food and recipe are not available.";
    });
    return;
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
        backgroundColor: const Color(0xFFCCD5AE),
        title: Text(
          widget.title,
          style: GoogleFonts.lilyScriptOne(fontSize: 35),
        ),
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
                  backgroundColor: const Color(0xFFCCD5AE), 
                ),
                child: Text("Choose or hold to capture", style: 
                GoogleFonts.lilyScriptOne(fontSize: 20, color: Colors.black),
                ) ,
              ),
              Card(
                //color: const Color(0xFFFEFAE0), // Text container color
                margin: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        results.isEmpty
                            ? "No food detected"
                            : "$results ",
                        style: GoogleFonts.lilyScriptOne(fontSize: 20, color: Colors.black),
                      ),
                      if (matchedRecipe != null) ...[
                    
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
                          child: Text('View Recipe' , style:GoogleFonts.lilyScriptOne(fontSize: 20, color: Colors.black)),
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


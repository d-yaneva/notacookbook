import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Not a cookbook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  late ImagePicker imagePicker;
  late ImageLabeler labeler;

  @override
  void initState() {

    super.initState();
    imagePicker = ImagePicker();

    //  ImageLabelerOptions options = ImageLabelerOptions(confidenceThreshold: 0.6); // from 0 to 1
    //  labeler = ImageLabeler(options: options);
    loadModel();
  }

loadModel() async {
  final modelPath = await getModelPath('assets/foods.tflite');
final options = LocalLabelerOptions(
  confidenceThreshold: 0.8,
  modelPath: modelPath,
);
 labeler = ImageLabeler(options: options);
}

   chooseImage()async{
    XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selectedImage != null){
      image = File(selectedImage.path);
      performImageLabeling();
      setState(() {
        image;
      });
    }

  }

   captureImage()async{
    XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if(selectedImage != null){
      image = File(selectedImage.path);
      performImageLabeling();
      setState(() {
        image;
      });
    }

  }

String results = "";

performImageLabeling() async {
  results = "";

InputImage inputImage = InputImage.fromFile(image!);

final List<ImageLabel> labels = await labeler.processImage(inputImage);

for (ImageLabel label in labels) {
  final String text = label.label;
  final int index = label.index;
  final double confidence = label.confidence;

  print(text+""+confidence.toString());
  results+=text+""+confidence.toStringAsFixed(2)+"\n";

  setState(() {
    results;
  });
}

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                child: image == null
                    ? Icon(Icons.image_outlined, size: 58)
                    : Image.file(image!),
              ),         
            ElevatedButton(onPressed: () {
              chooseImage();
            },onLongPress: (){
              captureImage();
            },
             child: const Text('Choose or capture')),
            Card(
              color: Colors.white10,
              child: Container(
                child:Text(results,style: TextStyle(fontSize: 21),),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
              
              ) , 
               margin: EdgeInsets.all(10),
            )        
          ],
        ),
        ),
      ),
    );
  }
}

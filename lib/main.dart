
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p13/WelcomeScreen.dart';
import 'package:p13/cubit/cubit/fetch_undertone_cubit.dart';
import 'package:p13/cubit/undertone_cubit.dart';
import 'package:p13/match.dart';
import 'package:p13/model/undertone_model.dart';
import 'package:p13/nomatch.dart';
import 'home.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//main
// This initializes Hive for Flutter, registers the UndertoneModel adapter for storing custom data types,
// opens a local storage box named "undertone" to save the user's undertone data,
// and then launches the main Flutter app.
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UndertoneModelAdapter());
  await Hive.openBox<UndertoneModel>("undertone");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Provides multiple BlocProviders to the widget tree, 
// making UndertoneCubit and FetchUndertoneCubit available throughout the app.
// This allows different parts of the app to access and manage undertone data and its fetching logic.
@override
Widget build(BuildContext context) {
return MultiBlocProvider(
providers: [
BlocProvider(create: (_) => UndertoneCubit()),
BlocProvider(create: (_) => FetchUndertoneCubit()),
],
child: ScreenUtilInit(  // Initializes ScreenUtil with the base design size (360x690) to ensure responsive UI scaling
designSize: const Size(360, 690), 
minTextAdapt: true,
splitScreenMode: true,
builder: (context, child) {
return MaterialApp(
debugShowCheckedModeBanner: false,
home: const WelcomeScreen(),
builder: (context, widget) {
ScreenUtil.init(context);
return widget!;
},
);
},
),
);
}
}
// Provides multiple Cubits (UndertoneCubit and FetchUndertoneCubit) to the widget tree so they can be accessed anywhere in the app.
@override
Widget build(BuildContext context) {
return MultiBlocProvider(
providers: [
BlocProvider(
create: (context) => UndertoneCubit(),
),
BlocProvider(
create: (context) => FetchUndertoneCubit(),
),
],
child: const MaterialApp(
debugShowCheckedModeBanner: false,
home: WelcomeScreen(),
),
);
}

//class TestColorNew 
class TestColorNew extends StatefulWidget {
const TestColorNew({super.key});

@override
_TestColorNewState createState() => _TestColorNewState();
}

class _TestColorNewState extends State<TestColorNew> {
File? _image;

 
// Determines the image format (png or jpeg) based on the file extension,
// returning 'png' for PNG files, 'jpeg' for JPEG/JPG files, and defaults to 'jpg' if unknown.
String _getImageFormat(XFile image) {
final extension = image.path.split('.').last.toLowerCase();
if (extension == 'png') return 'png';
if (extension == 'jpeg' || extension == 'jpg') return 'jpeg';
return 'jpg'; // default
}

Future<void> _pickAndAnalyzeImage(ImageSource source) async {
final Uint8List bytes;
try {
final XFile? image = await ImagePicker().pickImage(
source: source,
imageQuality: 90,
);

if (image != null) {
bytes = await image.readAsBytes();

final uri = Uri.parse('http://localhost:5002/analyze');  //POST request to send the image to the server for analysis
final request = http.MultipartRequest('POST', uri)
..files.add(http.MultipartFile.fromBytes(
'image',
bytes,
filename: image.name,
contentType: MediaType('image', _getImageFormat(image)),
));

final response = await request.send();
final responseBody = await response.stream.bytesToString();

if (response.statusCode == 200) {// If the request is successful (status code 200), extract the 'season' value
final data = json.decode(responseBody);
log('Season: ${data['season']}');

// Extract RGB values from the response
final List<int> rgbValues = List<int>.from(data['rgb']);
log('RGB Values: $rgbValues');

// for test usage of RGB values
final int red = rgbValues[0];
final int green = rgbValues[1];
final int blue = rgbValues[2];
log('Red: $red, Green: $green, Blue: $blue');

// Compare stored undertone with color
String? newSeason =
BlocProvider.of<FetchUndertoneCubit>(context).value?.season;
BlocProvider.of<FetchUndertoneCubit>(context).fetch();
if (BlocProvider.of<FetchUndertoneCubit>(context).value?.season ==
data["season"].toString().toLowerCase()) {
BlocProvider.of<FetchUndertoneCubit>(context).value?.delete();
Navigator.push(context,
MaterialPageRoute(builder: (context) => ColorMatchPage())); //match

BlocProvider.of<UndertoneCubit>(context)
.fun(UndertoneModel(season: newSeason!, image: bytes));
BlocProvider.of<FetchUndertoneCubit>(context).fetch();
} else {
Navigator.push(context,
MaterialPageRoute(builder: (context) => ColorMatchPage())); //not match


}
// Handle errors by showing a SnackBar with the error message to the user 
} else {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('Error: ${json.decode(responseBody)['error']}')),
);
log('Error: ${json.decode(responseBody)['error']}');
}
}
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Error: ${e.toString()}')),
);
log('Error: ${e.toString()}');
}
}

 
//warning
void _showAlertDialog(BuildContext context) {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: const Text('Warning'),
content: const Text('You must take a picture from Undertone page first'),
actions: <Widget>[
TextButton(
onPressed: () {
// Close the dialog
Navigator.of(context).pop();
},
child: const Text('OK'),
),
],
);
},
);
}

// Builds the main UI using BlocBuilder
@override
Widget build(BuildContext context) {
return BlocBuilder<FetchUndertoneCubit, FetchUndertoneState>(
builder: (context, state) {
return Scaffold(
backgroundColor: Colors.white,
extendBodyBehindAppBar: true,
appBar: PreferredSize(
preferredSize: const Size.fromHeight(120.0),
child: ClipPath(
clipper: CustomAppBarClipper(),
child: AppBar(
automaticallyImplyLeading: false,
elevation: 0,
flexibleSpace: Container(
decoration: const BoxDecoration(
gradient: LinearGradient(
colors: [
Color(0xFFFCCB90),
Color(0xFFE6A0C3),
Color(0xFFD57EEB),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
),
centerTitle: true,
title: const Text(
"Check Color",
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),

// actions
actions: [
Padding(
padding: const EdgeInsets.only(right: 16.0, top: 2.0),
child: ClipRRect(
borderRadius: BorderRadius.circular(20),
child: Icon(
Icons.check,
size: 55,
color: Colors.white,
),
),
),
],
),
),
),

body: SafeArea(
child: SingleChildScrollView(
child: Column(
children: [
Container(
height: 1,
color:Colors.white,
),
//SafeArea
const SizedBox(height: 20),
const Text(
"Start the color test now!",
style: TextStyle(
fontSize: 23,
fontWeight: FontWeight.bold,
color: Color(0XFFFCD0DD),
),
),
const SizedBox(height: 20),
Container(
width: 250,
height: 250,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
border:
Border.all(color: const Color(0XFFFCD0DD), width: 1),
gradient: const LinearGradient(
colors: [
Color(0xFFFAD0C4),
Color(0xFFFAD0C4),
Color(0xFFFAD0C7),
Color(0xFFFFD1FF),
],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
child: const Icon(Icons.camera_alt,
size: 80, color: Colors.black45),
),
const SizedBox(height: 20),
ElevatedButton(
onPressed: () {
if (state is FetchUndertonehasData) {
_pickAndAnalyzeImage(ImageSource.camera);
} else {
_showAlertDialog(context);
}
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0XFFFCD0DD),
foregroundColor: Colors.white,
minimumSize: const Size(250, 60),
padding: const EdgeInsets.symmetric(vertical: 15),
),
// Elevated button to take a photo using the camera
// Only works if undertone data is available; otherwise shows an alert dialog
child: const Text("Take a photo"),
),
const SizedBox(height: 10),
OutlinedButton(
onPressed: () {
if (state is FetchUndertonehasData) {
_pickAndAnalyzeImage(ImageSource.gallery);  
} else {
_showAlertDialog(context); //shows an alert dialog
}
},
style: OutlinedButton.styleFrom(
side: const BorderSide(color: Color(0XFFFCD0DD)),
foregroundColor: const Color(0xFFFCD0DD),
minimumSize: const Size(250, 60),
padding: const EdgeInsets.symmetric(vertical: 15),
),
child: const Text("Choose from photos"),
),
const SizedBox(height: 10),
],
),
),
),
);
},
);
}
}

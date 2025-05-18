import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import "package:http_parser/src/media_type.dart";
import 'package:p13/cubit/cubit/fetch_undertone_cubit.dart';
import 'package:p13/cubit/undertone_cubit.dart';
import 'package:p13/model/undertone_model.dart';

class Selfie extends StatefulWidget {
const Selfie({super.key});

@override
_SelfieState createState() => _SelfieState();
}

class _SelfieState extends State<Selfie> {
File? _image;
bool _isLoading = false; // Indicates if a loading process

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white, 
body: SafeArea(
child: Column(
children: [
//the main content of the selfie screen,
Padding(
padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
child: Column(
children: [
Text(
  "What is your undertone?",
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  textAlign: TextAlign.center,
),
SizedBox(height: 8.h),
Text(
  "Take a selfie to find out!",
  style: TextStyle(
    fontSize: 16,
    color: Colors.black54,
  ),
  textAlign: TextAlign.center,
),
],
),
),

//Image in selfie screen,
Expanded(
child: Center(
child: Image.asset(
'asset/1.png', 
width: 200.w,
height: 200.h,

),
),
),

if (_isLoading)
const Padding(
padding: EdgeInsets.only(bottom: 10),
child: CircularProgressIndicator(), //// Show a circular loading indicator with bottom padding when loading is true
),


Padding(
padding: const EdgeInsets.only(bottom: 20),
child: Column(
children: [
ElevatedButton(
onPressed: () => _pickImage(ImageSource.camera),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.pink[200],
minimumSize: const Size(300, 50), 
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
),
),
// pick an image from the given source (camera or gallery).
child: const Text(
"Take a photo",
style: TextStyle(fontSize: 18, color: Colors.white),
),
),
SizedBox(height: 10.h),
OutlinedButton(
onPressed: () => _pickImage(ImageSource.gallery),
style: OutlinedButton.styleFrom(
side: BorderSide(color: Colors.pink[200]!),
minimumSize: const Size(300, 50), 
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
),
),
child: Text(
"Choose from photos",
style: TextStyle(fontSize: 18, color: Colors.pink[200]),
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
// Async function to pick an image from camera or gallery.
Future<void> _pickImage(ImageSource source) async {
final pickedFile = await ImagePicker().pickImage(source: source);
if (pickedFile != null) {
setState(() {
_isLoading = true;
});
// This code navigates to a new page displaying a centered loading spinne
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => Scaffold(
backgroundColor: Colors.white,
body: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
CircularProgressIndicator(
valueColor: AlwaysStoppedAnimation<Color>(
Color(0xFFE6A0C3),
),
strokeWidth: 6.w,
),
SizedBox(height: 30.h),
ShaderMask(
shaderCallback: (bounds) => LinearGradient(
colors: [
  Color(0xFFFCCB90),
  Color(0xFFE6A0C3),
  Color(0xFFD57EEB),
],
).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
child: const Text(
'Wait a few seconds to get your undertone', 
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 20,
color: Colors.white,  
fontWeight: FontWeight.bold,
),
),
),

],)
,)
)));
//This part of the code handles uploading images in a way that is appropriate for each platform
Uint8List imageBytes;
http.MultipartFile multipartFile;

if (kIsWeb) {//both 
imageBytes = await pickedFile.readAsBytes(); //web
multipartFile = http.MultipartFile.fromBytes(
'image',
imageBytes,
filename: 'image.jpg',
contentType: MediaType('image', 'jpeg'),
);
} else {
_image = File(pickedFile.path); //app
imageBytes = await _image!.readAsBytes();
multipartFile = await http.MultipartFile.fromPath(
'image',
_image!.path,
contentType: MediaType('image', 'jpeg'),
);
}

final request = http.MultipartRequest( //
'POST',
Uri.parse('https://season-api-nzfj.onrender.com/predict'),// Create a multipart POST request to send the image file

);

request.files.add(multipartFile);
try {
  final response = await request.send();

  if (response.statusCode == 200) {
    // If the response is successful (status code 200),
    // parse the JSON response and extract the predicted season label,
    // then update the UndertoneCubit with the predicted season and image data.
    final body = await response.stream.bytesToString();
    final decoded = json.decode(body);
    final predictedSeason = decoded['label'];

    BlocProvider.of<UndertoneCubit>(context).fun(
      UndertoneModel(
        season: predictedSeason,
        image: imageBytes,
      ),
    );
    return; // Stop further execution after successful response
  }

  // If response status is not 200, throw an exception to handle in catch block
  throw Exception('Failed to get valid response');

} catch (e) {

  print('Failed to get valid season data from server.');
 
}

   finally {
  setState(() {
    _isLoading = false;
  });

  Navigator.pop(context);
  Navigator.pop(context);
  BlocProvider.of<FetchUndertoneCubit>(context).fetch();

  }
  }
  }
  }
  
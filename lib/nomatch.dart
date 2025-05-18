import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p13/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';

// StatelessWidget page that displays a gradient background,
class ColorMismatchPage extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
width: double.infinity,
decoration: const BoxDecoration(
color: Color(0xFFFEC8D8), 
),

child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
//imge
Image.asset(
'assetss/erroror.png',
height: 180.h,
),
SizedBox(height: 30.h),

//text
const Text(
'Opps! Unfortunately,',
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),

SizedBox(height: 10.h),

//text
const Text(
'the color doesn’t match with your undertone\nplease Try again',
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 16,
color: Color(0xFFCE7BB0),
),
),

SizedBox(height: 40.h),
// "Try Again" button that closes the current page and returns to the previous screen.
ElevatedButton(
onPressed: () {
// TestColorNew
Navigator.pop(context);
},
style: ElevatedButton.styleFrom(
backgroundColor: Color.fromARGB(255, 255, 255, 255),
minimumSize: const Size(200, 50),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
side: BorderSide(color: Color(0xFFCE7BB0)),
),
),
child: const Text(
'Try Again',
style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  color: Color(0xFFCE7BB0),
),
),
),

SizedBox(height: 20.h),
// Skip button that navigates the user to the Home page.
TextButton(
onPressed: () {

Navigator.push(
context,
MaterialPageRoute(builder: (context) => Home()),
);
},
child: const Text(
'Skip',
style: TextStyle(
fontSize: 16,
color: Color.fromARGB(255, 255, 255, 255),
  fontWeight: FontWeight.bold,
                  
),
),
),
],
),
),
);
}
}

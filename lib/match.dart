import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
class ColorMatchPage extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
// Stateless widget page displaying a gradient background,
body: Container(
width: double.infinity,
decoration: const BoxDecoration(
color: Color(0xFFFEC8D8), 
),


child: Center(
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 30),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
//icons
const Icon(
Icons.emoji_emotions,
size: 120,
color: Colors.white,
),

SizedBox(height: 30.h),

//text
const Text(
'The color matches\nwith your undertone !',
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 22,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 50.h),

// "OK" button that navigates the user to the Home page when pressed.

ElevatedButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => Home ()),
);
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
),
child: const Text(
'OK',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 18,
color: Color(0xFFCE7BB0), 
),
),
),
],
),
),
),
),
);
}
}

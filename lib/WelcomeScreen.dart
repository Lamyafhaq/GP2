import 'package:flutter/material.dart';
import 'package:p13/requires.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
const WelcomeScreen({super.key});
@override
 _WelcomeScreenState createState() => _WelcomeScreenState();
}
// Boolean to track whether the user has checked the agreement
class _WelcomeScreenState extends State<WelcomeScreen> {
bool isChecked = false;

  @override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
 body: Stack(
children: [
  CustomPaint(
 painter: BackgroundPainter(),
 child: Container(),
   ),
     // Positioned welcome text at the top left
   Positioned(
   top: 40,
   left: 20,
   child: const Text(
  "Welcome To,\n ColorTone !",
   style: TextStyle(
   fontSize: 27,
 fontWeight: FontWeight.bold,
   color: Colors.white,
     ),
      ),
     ),
 Center(
  //Centered column containing an image and a centered descriptive text
 child: Column(
 mainAxisSize: MainAxisSize.min,
 children: [
 Image.asset(
 'assets/1.png',
  height: 220,
  width: 220,
    ),
 const SizedBox(height: 20),
 const Text(
"Unveil your unique undertone\nand find your perfect colors",
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 20,
 fontWeight: FontWeight.bold,
 color: Color(0xFFF57EA1),
   ),
    ),
const SizedBox(height: 20),
 Row(
 mainAxisAlignment: MainAxisAlignment.center,
 children: [
 Checkbox(
 value: isChecked,
 onChanged: (bool? value) {
setState(() {
 isChecked = value!;  // Update the isChecked state with the new checkbox value
  });
   },
  ),
 const Text(
 "I agree to the Terms & Conditions",
 style: TextStyle(fontSize: 16),
   ),
   ],
   ),
   ],
   ),
   ),
 Positioned(
 bottom: 32,
 left: 0,
right: 0,
 child: Center(
child: ElevatedButton(
   style: ElevatedButton.styleFrom(
 backgroundColor: Colors.white,
 shape: RoundedRectangleBorder(
 borderRadius: BorderRadius.circular(30),
  ),
padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
 ),
onPressed: isChecked
 ? () {
// Navigate to Requires screen only if checkbox is checked
   Navigator.pushReplacement(
 context,
 MaterialPageRoute(builder: (context) => Requires()),
  );
     }
   : null,
child: Row(
 mainAxisSize: MainAxisSize.min,
 children: const [
Text(
 "Get Started",
style: TextStyle(
color: Colors.black,
fontSize: 20,
fontWeight: FontWeight.bold,
 ),
),
 SizedBox(width: 8),
Icon(Icons.arrow_forward, color: Colors.black),
 ],
 ),
 ),
 ),
),
],
),
);
}
}
//paint a decorative background with smooth gradient waves.
class BackgroundPainter extends CustomPainter {
  @override
void paint(Canvas canvas, Size size) {
final topGradientPaint = Paint()
..shader = LinearGradient(
   colors: [Color(0xFFFFD1FF), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
  ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

final topPath = Path();
topPath.lineTo(0, size.height * 0.2);
topPath.quadraticBezierTo(
size.width * 0.5, size.height * 0.1, size.width, size.height * 0.2);
topPath.lineTo(size.width, 0);
topPath.close();
canvas.drawPath(topPath, topGradientPaint);

final bottomGradientPaint = Paint()
..shader = LinearGradient(
colors: [Color(0xFFFAD0C4), Color(0xFFFAD0C4), Color(0xFFFFD1FF)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

final bottomPath = Path();
bottomPath.moveTo(0, size.height * 0.8);
 bottomPath.quadraticBezierTo(
size.width * 0.5, size.height * 0.9, size.width, size.height * 0.8);
bottomPath.lineTo(size.width, size.height);
 bottomPath.lineTo(0, size.height);
  bottomPath.close();
canvas.drawPath(bottomPath, bottomGradientPaint);
  }

 @override
bool shouldRepaint(CustomPainter oldDelegate) => false;
}

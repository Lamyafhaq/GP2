import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';


class Requires extends StatelessWidget {
const Requires({super.key});

 @override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white, 
body: Stack(
children: [
 // Draw gradient background 
 CustomPaint(
painter: WavePainter(),
child: Container(),
 ),
// Centered container with rounded corners, blur effect, and semi-transparent background
Center(
child: ClipRRect(
borderRadius: BorderRadius.circular(15),
child: BackdropFilter(
filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
child: Container(
width: MediaQuery.of(context).size.width * 0.8,
 decoration: BoxDecoration(
color: Color.fromARGB(255, 213, 111, 193).withOpacity(0.7),
borderRadius: BorderRadius.circular(15),
 border: Border.all(color: Colors.white.withOpacity(0.2)),
 ),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
mainAxisSize: MainAxisSize.min,
children: [
   Padding(
 padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
 children: [
Text(
"To enhance your experience, this app needs access to your camera and photos",//  the app needs access to camera and photos
 textAlign: TextAlign.left,
style: TextStyle(
fontSize: 20,
 color: Colors.white,
 ),
  ),
   // Vertical spacing between the texts
SizedBox(height: 10.h),
 Text(
 "Do you allow this?",  //  question asking the user for permission
textAlign: TextAlign.left,
 style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.white,
 ),
 ),
],
),
),
SizedBox(height: 20.h),
 Container(
height: 0.5.h,
width: MediaQuery.of(context).size.width * 0.7,
color: Colors.white,
 ),
Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Expanded(
child: GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => const Home ()),
 );
  },
child: const Center(
child: Text(
 "Allow",  // "Allow" button 
style: TextStyle(
color: Colors.white,
 fontWeight: FontWeight.bold,
 ),
 ),
 ),
 ),
 ),
Container(
   width: 1.w,
height: MediaQuery.of(context).size.height * 0.07,
 color: Colors.white,
  ),
const Expanded(
child: Center(
child: Text(
   "Don't Allow", // "Don't Allow" button 
  style: TextStyle(
color: Colors.white,
 fontWeight: FontWeight.bold,
                                 ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
class WavePainter extends CustomPainter {
@override
  void paint(Canvas canvas, Size size) {
final upperWavePaint = Paint()
 ..shader = const LinearGradient(
  colors: [
Color(0xFFFCCB90),
Color(0xFFE6A0C3),
Color(0xFFD57EEB),
        ],
 begin: Alignment.topLeft,
  end: Alignment.bottomRight,
 ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

final upperWavePath = Path();
upperWavePath.moveTo(0, size.height * 0.05);
upperWavePath.quadraticBezierTo(
size.width * 0.5, size.height * 0.1, size.width, size.height * 0.05);
upperWavePath.lineTo(size.width, 0);
upperWavePath.lineTo(0, 0);
upperWavePath.close();
canvas.drawPath(upperWavePath, upperWavePaint);

final lowerWavePaint = Paint()
..shader = const LinearGradient(
 colors: [
 Color(0xFFD57EEB),
 Color(0xFFE6A0C3),
 Color(0xFFFCCB90),
        ],
 begin: Alignment.bottomLeft,
 end: Alignment.topRight,
  ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

final lowerWavePath = Path();
lowerWavePath.moveTo(0, size.height * 0.9);
lowerWavePath.quadraticBezierTo(
size.width * 0.5, size.height, size.width, size.height * 0.9);
lowerWavePath.lineTo(size.width, size.height);
lowerWavePath.lineTo(0, size.height);
lowerWavePath.close();
canvas.drawPath(lowerWavePath, lowerWavePaint);
  }

@override
bool shouldRepaint(CustomPainter oldDelegate) => false;
}

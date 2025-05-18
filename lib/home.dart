import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p13/main.dart';
import 'MyPalettePage.dart'; 
import 'UNDERTONE.dart'; 


class Home extends StatefulWidget {
const Home({super.key});

 @override
_homeState createState() => _homeState();
}
// The state class for the Home widget
class _homeState extends State<Home> {
int _currentIndex = 0; // Current tab index

final List<Widget> _pages = [
const HomePage(), // First page
const UNDERTONE(), // Second page
const TestColorNew (), // Third page
const PaletteScreen(),// Fourth page
  ];

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
 body: IndexedStack(
index: _currentIndex,
children: _pages,
  ),
 // Bottom navigation bar to switch between different pages
bottomNavigationBar: BottomNavigationBar(
type: BottomNavigationBarType.fixed,
selectedItemColor: Colors.pink,
unselectedItemColor: Colors.grey,
currentIndex: _currentIndex,// Highlights the currently selected tab
onTap: (index) {
setState(() {
_currentIndex = index;
     });
 },
  items: const [
  BottomNavigationBarItem(
  icon: Icon(Icons.home), // Icon for the Home screen
 label:  "HOME", // Label displayed below the icon
   ),
  BottomNavigationBarItem(
  icon: Icon(Icons.face),// Icon for the Undertone screen
  label: "MY UNDERTONE",// Label for the Undertone tab
    ),
   BottomNavigationBarItem(
  icon: Icon(Icons.check),// Icon for the color checking
  label: "CHECK COLOR",// Label for the color check
   ),
   BottomNavigationBarItem(
  icon: Icon(Icons.palette),// Icon for the user's color palette
  label: "MY PALETTE",// Label for the palette tab
          ),
        ],
      ),
    );
  }
}

// HomePage content
class HomePage extends StatelessWidget {
  const HomePage({super.key});


@override
// Applies a linear gradient
Widget build(BuildContext context) {
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
  // Title text and home icon action on the app bar
title: const Text(
"Home",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 30,
),
),
actions: [
Padding(
padding: const EdgeInsets.only(right: 16.0, top: 2.0),
child: Icon(Icons.home, size: 55, color: Colors.white),
),
],
),
),
),

            
body: Container(
color: Colors.white,
 child: SingleChildScrollView(
child: Column(
children: [
const SizedBox(height: 120),
 Image.asset(
'assetss/logo.png', //Display app logo
 height: 250,
width: 250,
  ),
  const SizedBox(height: 30),
  Container(
  padding: const EdgeInsets.all(16),
   width: double.infinity,
  decoration: BoxDecoration(
 color: Colors.white, // White background color
 border: Border(
  top: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                ),
 child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,// Align children to the start (left)
  children: [
  Container(
 width: double.infinity,
 padding: const EdgeInsets.symmetric(
 vertical: 8, horizontal: 12),
 decoration: BoxDecoration(
  color: const Color(0xFFFED1F6),
 borderRadius: BorderRadius.circular(8),
   ),
 child: const Text(
  "About us:",
  style: TextStyle(
 fontSize: 18,
 fontWeight: FontWeight.bold,
 color: Colors.black,
      ),
    ),
   ),
   const SizedBox(height: 15),  // Spacer between sections
Row(
crossAxisAlignment: CrossAxisAlignment.start,  // Align row children to the top
children: [
Expanded(
child: Container(
padding: const EdgeInsets.all(12),  // Padding inside the container
decoration: BoxDecoration(
border: Border.all(color: Color(0xFFFED1F6), width: 1.5),  // Light pink border with width 1.5
borderRadius: BorderRadius.circular(8),  
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,  // Align column children to the start (left)
children: [
Text(
"What is Color Theory?",  // Section heading text
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
    SizedBox(height: 5),  // Small vertical space between heading and description
Text(
  "Color theory helps you choose harmonious colors that complement each other and enhance your appearance, based on the color wheel.",  // Description text explaining color theory
  style: TextStyle(fontSize: 14),
),
                                   
],
),
),
),
const SizedBox(width: 10),
Expanded(
child: Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
border: Border.all(color: Color(0xFFFED1F6), width: 1.5),
borderRadius: BorderRadius.circular(8),
),
// This section explains the concept of "Undertone" 
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
children: [
Text(
  "What is Undertone?",
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),
SizedBox(height: 5),
Text(
  "Undertone refers to the subtle underlying tone of your skin. It determines which colors suit you best, divided into: Spring, Summer, Autumn, and Winter.",
  style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
);
}
}
//paint a decorative background with smooth gradient waves.
class CustomAppBarClipper extends CustomClipper<Path> {
@override
Path getClip(Size size) {
Path path = Path();
path.lineTo(0, 0);
path.lineTo(0, size.height - 30);
path.quadraticBezierTo(
  size.width / 2, size.height + 30, size.width, size.height - 30);
path.lineTo(size.width, 0);
path.close();
return path;
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

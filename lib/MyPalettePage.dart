import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p13/cubit/cubit/fetch_undertone_cubit.dart';
import 'package:p13/main.dart';
import 'home.dart';
import 'UNDERTONE.dart';

// class abBarItem
class TabBarItem {
final IconData icon;
final String label;
final Widget page;

TabBarItem(this.icon, this.label, this.page);
}

class PaletteScreen extends StatefulWidget {
const PaletteScreen({super.key});

@override
_PaletteScreenState createState() => _PaletteScreenState();
}

class _PaletteScreenState extends State<PaletteScreen> {
final PageController _pageController = PageController(initialPage: 3);
int indexTap = 3;

List<TabBarItem> tabItems = [];
// List of BottomNavigationBarItems defining the icons and labels
// for each tab in the bottom navigation bar.
@override
void initState() {
super.initState();
tabItems = [
TabBarItem(Icons.home, "Home", const Home ()),
TabBarItem(Icons.face, "Undertone", const UNDERTONE()),
TabBarItem(Icons.check, "Test", TestColorNew()),
TabBarItem(
Icons.palette, "Palette", const MyPalettePage()), // الصفحة الحالية

];
}
// Scaffold containing
@override
void dispose() {
_pageController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: PageView(
controller: _pageController,
children: _getChildrenTabBar(),
onPageChanged: (index) {
setState(() {
  indexTap = index;
});
},
),
);
}
// Returns a list of pages extracted from tabItems for display in PageView.
// Generates BottomNavigationBarItems dynamically from tabItems,
// highlighting the currently selected tab with a different icon color.

List<Widget> _getChildrenTabBar() {
return tabItems.map((item) => item.page).toList();
}

List<BottomNavigationBarItem> _renderTaps() {
return List.generate(tabItems.length, (i) {
return BottomNavigationBarItem(
icon: Icon(
tabItems[i].icon,
color: indexTap == i ? Colors.pink.shade300 : Colors.black26,
),
label: tabItems[i].label,
);
});
}
}
// class MyPalettePage 
class MyPalettePage extends StatelessWidget {
  const MyPalettePage({super.key});
//body class MyPalettePage 
  @override
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
title: const Text(
"My Palette",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 30,
),
),
actions: [
Padding(
padding: const EdgeInsets.only(right: 16.0, top: 2.0),
child: ClipRRect(
borderRadius: BorderRadius.circular(20),
child: Icon(Icons.palette ,
size: 55, color: const Color.fromARGB(255, 255, 255, 255)),

),
),

],
),
),
),
 // Builds the UI based on the state of FetchUndertoneCubit using BlocBuilder
// - If data is available (FetchUndertonehasData), display an image corresponding to the stored season value
// - The image is loaded from the "new_images" folder using the season name

body: BlocBuilder<FetchUndertoneCubit, FetchUndertoneState>(
builder: (context, state) {
return Stack(
children: [
state is FetchUndertonehasData
? Center(
child: Image.asset(
width: MediaQuery.sizeOf(context).width * 0.7,
"new_images/${BlocProvider.of<FetchUndertoneCubit>(context).value!.season}.jpg"))
:

Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
SizedBox(height: 20),
Text(
"There Is No PALETTE Store Yet..", // message displayed when there is no palette data available
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Color.fromARGB(255, 0, 0, 0),
),
),
],
),
),
],
);
},
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
bool shouldReclip(CustomClipper<Path> oldClipper) {
return false;
}
}

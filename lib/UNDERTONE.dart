import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p13/cubit/cubit/fetch_undertone_cubit.dart';
import 'package:p13/cubit/undertone_cubit.dart';
import 'package:p13/model/undertone_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p13/selfie.dart';
import 'home.dart';

class UNDERTONE extends StatefulWidget {
final UndertoneModel? undertoneModel;
const UNDERTONE({super.key, this.undertoneModel});

@override
State<UNDERTONE> createState() => _UNDERTONEState();
}

class _UNDERTONEState extends State<UNDERTONE> {
@override
void initState() {
  super.initState();
}

// Function to show a confirmation dialog before deleting undertone data
void _showAlertDialog(BuildContext context) {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: const Text('Warning'),
content: const Text(
'IF You Delete The Undertone everything will be Delete it'),
actions: <Widget>[
TextButton(
onPressed: () {
// Close the dialog
Navigator.of(context).pop();
print('User clicked Cancel');
},
child: const Text('Cancel'),
),
TextButton(
onPressed: () {
// Delete 
BlocProvider.of<FetchUndertoneCubit>(context).value!.delete();
BlocProvider.of<FetchUndertoneCubit>(context).fetch();

Navigator.of(context).pop();
print('User clicked OK');
},
child: const Text('OK'),
),
],
);
},
);
}

@override
Widget build(BuildContext context) {
  // Fetch and update the undertone data each time the widget is built
BlocProvider.of<FetchUndertoneCubit>(context).fetch();
// Main scaffold with a custom app bar having a gradient background 
return Scaffold(
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
// The title text widget
title: const Text(
"My Undertone",
style: TextStyle(
fontSize: 33,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
// Actions widgets displayed on the right side
actions: [
Padding(
padding: const EdgeInsets.only(right: 16.0, top: 2.0),
child: ClipRRect(
borderRadius: BorderRadius.circular(20),
child: Icon(Icons.face,
size: 55, color: const Color.fromARGB(255, 255, 255, 255)),

                ),
              ),
            ],
          ),
        ),
      ),
body: BlocBuilder<FetchUndertoneCubit, FetchUndertoneState>(
builder: (context, state) {
return Stack(
children: [
Container(
decoration: const BoxDecoration(
gradient: LinearGradient(
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFFFFFFFF),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
),
),
),
//widget uses ClipPat
ClipPath(
clipper: CustomBodyClipper(),
child: Container(
width: double.infinity,
height: double.infinity,
decoration: BoxDecoration(
color: Colors.white,
boxShadow: [
BoxShadow(
color: Colors.grey.withOpacity(0.3),
spreadRadius: 2,
blurRadius: 5,
offset: const Offset(0, 3),
),
],
),
child: Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
if (state is FetchUndertonehasData &&      //Check if the current state has Undertone data  
BlocProvider.of<FetchUndertoneCubit>(context)
      .value!
      .image !=
  null)
Padding(
padding:  EdgeInsets.only(bottom: 20.0),
child: ClipRRect(
borderRadius: BorderRadius.circular(12),
child: Image.memory(
  BlocProvider.of<FetchUndertoneCubit>(context)
      .value!
      .image!,
  height: 200,
  width: 200,
  fit: BoxFit.cover,
),
),
),
Text(
state is FetchUndertonehasData
? "Your Undertone is ${BlocProvider.of<FetchUndertoneCubit>(context).value!.season}" // ✅ Display the user's undertone season if available
: 'There Is No Undertone Store Yet..', // ❌ otherwise, show a message indicating no undertone is stored yet
style: const TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Colors.black,
),
textAlign: TextAlign.center,
),

],
),
),
),
),

Align(
alignment: Alignment.bottomCenter,
child: Padding(
padding: const EdgeInsets.only(
bottom: 50.0), 
child: ElevatedButton(
onPressed: () {
if (state is FetchUndertonehasData) {

_showAlertDialog(context); //it prompts the user with a confirmation alert dialog to delete the data.
} else {
Navigator.push(
context,
MaterialPageRoute(
    builder: (context) => const Selfie()), //it navigates the user to the Selfie screen to capture and analyze a new undertone
);
}
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFE6A0C3),
padding: const EdgeInsets.symmetric(
horizontal: 30, vertical: 15),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(25),
),
),
child: Text(
state is FetchUndertonehasData
? "Delete Undertone" // Show "Delete Undertone" if undertone data exists
: 'Detect Undertone',   // Otherwise show "Detect Undertone"
style: const TextStyle(fontSize: 18, color: Colors.white),
),
),
  ),
)
],
);
},
),
);
}
}
// Custom clipper for the app bar shape
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

class CustomBodyClipper extends CustomClipper<Path> {
@override
Path getClip(Size size) {
  Path path = Path();
  path.lineTo(0, 0);
  path.lineTo(0, size.height);
  path.lineTo(size.width, size.height);
  path.lineTo(size.width, 0);
  path.close();
  return path;
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) {
  return false;
}
}


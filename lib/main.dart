import 'package:blog/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'service/slider.dart';
import 'package:blog/service/slider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
           colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.blue),
          scaffoldBackgroundColor: const Color(0xff1c202a),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const splashscreen());
  }

 
}
// class MyHomePage extends StatefulWidget {


//   @override


//   _MyHomePageState createState() => _MyHomePageState();


// }



// class _MyHomePageState extends State<MyHomePage> {


//   int currentIndex;



//   @override


//   void initState() {


//     super.initState();



//     currentIndex = 0;


//   }



//   changePage(int index) {


//     setState(() {


//       currentIndex = index;


//     });


//   }



//   @override


//   Widget build(BuildContext context) {


//     return Scaffold(


//       appBar: AppBar(


//         title: Text(


//           'Dashboard',


//           style: TextStyle(


//             fontSize: 18.0,


//             color: Colors.black,


//             fontWeight: FontWeight.bold,


//           ),


//         ),


//         backgroundColor: Colors.white,


//       ),


//       bottomNavigationBar: BubbleBottomBar(


//         opacity: 0.2,


//         backgroundColor: Colors.white,


//         borderRadius: BorderRadius.vertical(


//           top: Radius.circular(16.0),


//         ),


//         currentIndex: currentIndex,


//         hasInk: true,


//         inkColor: Colors.black12,


//         onTap: changePage,


//         items: <BubbleBottomBarItem>[


//           BubbleBottomBarItem(


//             backgroundColor: Colors.red,


//             icon: Icon(


//               Icons.dashboard,


//               color: Colors.black,


//             ),


//             activeIcon: Icon(


//               Icons.dashboard,


//               color: Colors.red,


//             ),


//             title: Text('Home'),


//           ),


//           BubbleBottomBarItem(


//             backgroundColor: Colors.indigo,


//             icon: Icon(


//               Icons.folder_open,


//               color: Colors.black,


//             ),


//             activeIcon: Icon(


//               Icons.folder_open,


//               color: Colors.indigo,


//             ),


//             title: Text('Folders'),


//           ),


//           BubbleBottomBarItem(


//             backgroundColor: Colors.deepPurple,


//             icon: Icon(


//               Icons.access_time,


//               color: Colors.black,


//             ),


//             activeIcon: Icon(


//               Icons.access_time,


//               color: Colors.deepPurple,


//             ),


//             title: Text('Log'),


//           ),


//           BubbleBottomBarItem(


//             backgroundColor: Colors.green,


//             icon: Icon(


//               Icons.menu,


//               color: Colors.black,


//             ),


//             activeIcon: Icon(


//               Icons.menu,


//               color: Colors.green,


//             ),


//             title: Text('Menu'),


//           ),


//         ],


//       ),


//       body: (currentIndex == 0)


//           ? Hotstar()


//           : (currentIndex == 1)


//               ? Hotstar()


//               : (currentIndex == 2)


//                   ? Hotstar()


//                   : Hotstar(),


//     );


//   }


// }


import 'package:flutter/material.dart';
import 'calculator/calculator_page.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorPage(),
    debugShowCheckedModeBanner: false,
  ));
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<String> name = ["Bernard", "Ephraim", "Charles", "Grace"];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowMaterialGrid: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Charles' app",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.green,
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: name.map((String names) {
//             return Card(
//               color: Colors.green[300],
//               child: Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       names,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     Text(
//                       names,
//                       style: const TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }



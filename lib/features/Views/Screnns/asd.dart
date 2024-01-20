// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   static const String _title = 'Flutter Tutorial';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const Steps(),
//       ),
//     );
//   }
// }

// class Step {
//   Step(this.title, this.body, [this.isExpanded = false]);
//   String title;
//   String body;
//   bool isExpanded;
// }

// List<Step> getSteps() {
//   return [
//     Step('Step 0: Install Flutter',
//         'Install Flutter development tools according to the official documentation.'),
//     Step('Step 1: Create a project',
//         'Open your terminal, run `flutter create <project_name>` to create a new project.'),
//     Step('Step 2: Run the app',
//         'Change your terminal directory to the project directory, enter `flutter run`.'),
//   ];
// }

// class Steps extends StatefulWidget {
//   const Steps({Key? key}) : super(key: key);
//   @override
//   State<Steps> createState() => _StepsState();
// }

// class _StepsState extends State<Steps> {
//   final List<Step> _steps = getSteps();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Container(
//           child: _renderSteps(),
//         ),
//       ),
//     );
//   }

//   Widget _renderSteps() {
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           _steps[index].isExpanded = !isExpanded;
//         });
//       },
//       children: _steps.map<ExpansionPanel>((Step step) {
//         return ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return ListTile(
//               title: Text(step.title),
//             );
//           },
//           body: ListTile(
//             title: Text(step.body),
//           ),
//           isExpanded: step.isExpanded,
//         );
//       }).toList(),
//     );
//   }
// }

// class asd extends StatefulWidget {
//   const asd({
//     super.key,
//   });
//   @override
//   State<asd> createState() => _asdState();
// }

// class _asdState extends State<asd> {
//   List<ItemModel> prepareData = <ItemModel>[
//     ItemModel(
//       header: 'Milk',
//       bodyModel: BodyModel(price: 20, quantity: 10),
//     ),
//     ItemModel(
//       header: 'Coconut',
//       bodyModel: BodyModel(price: 35, quantity: 5),
//     ),
//     ItemModel(
//       header: 'Watch',
//       bodyModel: BodyModel(price: 800, quantity: 15),
//     ),
//     ItemModel(
//       header: 'Cup',
//       bodyModel: BodyModel(price: 80, quantity: 150),
//     )
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("ExpansionPanelList"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: ListView.builder(
//           itemCount: prepareData.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ExpansionPanelList(
//               children: [
//                 ExpansionPanel(
//                   body: Container(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(
//                           'PRICE: ${prepareData[index].bodyModel.price}',
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 18,
//                           ),
//                         ),
//                         Text(
//                           'QUANTITY: ${prepareData[index].bodyModel.quantity}',
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 18,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   headerBuilder: (BuildContext context, bool isExpanded) {
//                     return Container(
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         prepareData[index].header,
//                         style: const TextStyle(
//                           color: Colors.black54,
//                           fontSize: 18,
//                         ),
//                       ),
//                     );
//                   },
//                   isExpanded: prepareData[index].isExpanded,
//                 )
//               ],
//               expansionCallback: (int item, bool status) {
//                 setState(() {
//                   prepareData[index].isExpanded =
//                       !prepareData[index].isExpanded;
//                 });
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class ItemModel {
//   String header;
//   BodyModel bodyModel;
//   bool isExpanded;
//   ItemModel({
//     this.header = '',
//     required this.bodyModel,
//     this.isExpanded = false,
//   });
// }
// class Ex{
//     bool? isExpanded;
//     Ex([this.isExpanded=false]);

// }
// List<Ex>s=[];

// class BodyModel {
//   int price;
//   int quantity;
//   BodyModel({
//     this.price = 0,
//     this.quantity = 0,
//   });
// }

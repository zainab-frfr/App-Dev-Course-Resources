import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

//      DEFAULT TAB CONTROLLER PRACTICE       //

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TabBar widget practice'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 151, 177, 221),
            bottom: const TabBar(
              tabs: [
                Tab(child: Icon(Icons.add),),
                Tab(child: Icon(Icons.remove),),
                Tab(child: Icon(Icons.edit),),
              ]
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text('add'),),
              Center(child: Text('remove'),),
              Center(child: Text('edit'),),
            ]
          )
        ),
      ),
    );
  }
}

//              CUSTOM TAB CONTROLLER PRACTICE              //

// class MainApp extends StatelessWidget{
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TabBarExample()
//     );
//   }

// }

// class TabBarExample extends StatefulWidget {
//   const TabBarExample({super.key});

//   @override
//   State<TabBarExample> createState() => _TabBarExampleState();
// }

// class _TabBarExampleState extends State<TabBarExample> with SingleTickerProviderStateMixin{
//   late TabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TabController(
//       length: 3, 
//       vsync: this, 
//       initialIndex: 1,
//       animationDuration: const Duration(seconds: 20),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//    Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TabBar Example'),
//         centerTitle: true,
//         bottom: TabBar(
//           controller: _controller,
//           tabs: const [
//             Tab(icon: Icon(Icons.add)),
//             Tab(icon: Icon(Icons.remove)),
//             Tab(icon: Icon(Icons.edit)),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _controller,
//         children: const [
//           Center(child: Text('Add')),
//           Center(child: Text('Remove')),
//           Center(child: Text('Edit')),
//         ],
//       ),
//     );
//   }
// }
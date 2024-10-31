import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_practice/counter_notifier.dart';
import 'package:provider_practice/post_model.dart';
import 'package:provider_practice/post_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => PostNotifier())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Counter Provider'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '${context.watch<Counter>().counter}',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => context.read<Counter>().increment(),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    List<Post> posts = context.watch<PostNotifier>().post;
    bool dataFetched = context.watch<PostNotifier>().dataFetched;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: dataFetched
              ? ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].content),
                      leading: CircleAvatar(
                        child: Image.network(posts[index].image),
                      ),
                    );
                  })
              : const CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<PostNotifier>().fetchPosts(),
        tooltip: 'fetch data',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mid_bloc/launch_model.dart';
import 'package:mid_bloc/my%20widgets/my_launch_tile.dart';
import 'package:mid_bloc/state_management/bloc_dummy.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // late List<Launch> launches;
//   // bool _hasFetched = false;

//   // Future<void> getUsers() async{

//   //   Response apiResponse = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

//   //   if (apiResponse.statusCode == 200){
//   //     List<dynamic> decoded = jsonDecode(apiResponse.body);
//   //     //List jsonUsers = decoded['results'];

//   //     launches = decoded.map((launch) => Launch.fromJson(launch)).toList();

//   //     setState(() {
//   //       _hasFetched = true;
//   //     });

//   //   }else{
//   //     launches = [];
//   //     throw Exception('Problem in Fetching Data');
//   //   }
//   // }

//   // @override
//   // void initState() {
//   //   getUsers();
//   //   super.initState();

//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Products'),
//         ),
//         body: BlocBuilder<LaunchBloc, LaunchState>(builder: (context, state) {
//           if (state is LaunchLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is LaunchLoaded) {
//             return ListView.builder(
//                 itemCount: state.launches.length,
//                 itemBuilder: (context, index) {
//                   Launch currLaunch = state.launches[index];

//                   return MyLaunchTile(
//                     launch: currLaunch,
//                   );
//                 });
//           } else if (state is LaunchError) {
//             return Center(
//               child: Text(state.error),
//             );
//           } else {
//             return const Center(
//               child: Text('error fetching state'),
//             );
//           }
//         }));
//     // if(_hasFetched){
//     //   return ListView.builder(
//     //       itemCount: launches.length,
//     //       itemBuilder: (context, index) {
//     //         Launch curLaunch = launches[index];
//     //         return MyLaunchTile(
//     //           launch: curLaunch
//     //         );
            
//     //       }
//     //   );
//     // }
//     // else {
//     //   return const Center(
//     //     child: CircularProgressIndicator(),
//     //   );
//     // }
    
//   }

// }

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<LaunchBloc, LaunchState>(builder: (context, state) {
          if (state is LaunchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LaunchLoaded) {
            return ListView.builder(
                itemCount: state.launches.length,
                itemBuilder: (context, index) {
                  Launch currLaunch = state.launches[index];

                  return MyLaunchTile(
                    launch: currLaunch,
                  );
                });
          } else if (state is LaunchError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text('error fetching state'),
            );
          }
        });
  }
}
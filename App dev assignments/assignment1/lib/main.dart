import 'dart:convert'; // dart package for json decoding

import 'package:assignment1/jobs_model.dart';
import 'package:assignment1/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<List<Jobs>> fetchAllJobs() async { //decodes json http response to Jobs model 

    final response = await http.get(Uri.parse('https://mpa0771a40ef48fcdfb7.free.beeceptor.com/jobs'));

    //print(response.body);
    if (response.statusCode == 200) {
      Map<String,dynamic> jsonResponse = jsonDecode(response.body);
      
      List jsonJobs = jsonResponse['data']; //extracting jobs from jsonResponse 

      return jsonJobs.map((job) => Jobs.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        
        appBar: AppBar(
          title: const Text(
            'Jobs',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_outlined))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FutureBuilder(
            future: fetchAllJobs(), 
            builder: (context, snapshot) {

              if (snapshot.hasError){
                return const Center(child: Text('Error Retrieving Data'),);
              } else if (!snapshot.hasData){
                return const Center(child: Text('No Data To Retrieve'),);
              } else if(snapshot.hasData){

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 231, 222, 222), width: 1), 
                          borderRadius: BorderRadius.circular(10), 
                        ),
                        child: Column(
                          children: [
                            MyListTile(
                              network: (snapshot.data as List<Jobs>)[index].network,
                              jobTitle: (snapshot.data as List<Jobs>)[index].jobTitle,
                              company: (snapshot.data as List<Jobs>)[index].company,
                              location: (snapshot.data as List<Jobs>)[index].location,
                              onsiteOrHybrid: (snapshot.data as List<Jobs>)[index].onsiteOrHybrid,
                              partOrFullTime: (snapshot.data as List<Jobs>)[index].partOrFullTime,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                                  child: Text(
                                    (snapshot.data as List<Jobs>)[index].daysPassed,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }, 
                );
              } else{
                return const Center(child: Text('Confusion'),);
              }
              
            }
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_outlined),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              label: 'Resume',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

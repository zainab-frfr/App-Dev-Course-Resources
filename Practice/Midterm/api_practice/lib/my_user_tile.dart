import 'package:api_practice/user_model.dart';
import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final User user;
  const MyUserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1.2,
        child: InkWell(
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal:20 ),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(20),
          
            // ),
            //margin: const EdgeInsets.symmetric(vertical: 20,horizontal:10 ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(user.thumbnail),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          user.email
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${user.age}',
                      style:const TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
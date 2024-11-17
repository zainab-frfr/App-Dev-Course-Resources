import 'package:assignment3/ui/widgets/shimmer_container.dart';
import 'package:flutter/material.dart';

class MyShimmerTile extends StatelessWidget {
  const MyShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: const ListTile(
                leading: SizedBox(
                  height: 100,
                  width: 100,
                  child: MyShimmerContainer(width: 100, height: 100)
                ),
                title: Column(
                  children: [
                    MyShimmerContainer(width: 300, height: 5),
                    MyShimmerContainer(width: 300, height: 5)
                  ],
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyShimmerContainer(width: 200, height: 5),
                    MyShimmerContainer(width: 200, height: 5)
                  ],
                )),
          
      ),
    );
  }
  
}

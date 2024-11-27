import 'package:assignment3/bloc/bloc.dart';
import 'package:assignment3/data/news_model.dart';
import 'package:assignment3/ui/widgets/news_tile.dart';
import 'package:assignment3/ui/widgets/shimmer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const MyShimmerTile();
                    },
                  )),
            );
          case FetchedNews():
            debugPrint('fetched news');
            debugPrint('${state.allNews.length}');
            return ListView.builder(
                itemCount: state.allNews.length,
                itemBuilder: (context, index) {
                  News newsItem = state.allNews[index];

                  return MyNewsTile(
                    news: newsItem,
                  );
                });
          case ErrorState():
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          default:
            return const Center(child: Text('UNRECOGNIZED STATE'),);
        }
      },
    );
  }
}

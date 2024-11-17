// ignore_for_file: use_build_context_synchronously
import 'package:assignment3/data/news_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNewsTile extends StatelessWidget {
  final News news;
  const MyNewsTile({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: InkWell(
          onTap: () {
            showDetails(context);
          },
          child: Ink(
            child: ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: (news.urlToImage != 'Not Found' &&
                            news.urlToImage.isNotEmpty &&
                            Uri.tryParse(news.urlToImage)?.hasAbsolutePath ==
                                true)
                        ? Image.network(
                            news.urlToImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          )
                        : const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          )),
              ),
              title: Text(
                news.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(news.author), Text(news.publishedAt)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDetails(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      //scrollControlDisabledMaxHeightRatio: MediaQuery.sizeOf(context).height *0.75,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75, // Start at 75% of screen height
          minChildSize: 0.3,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(controller: scrollController, children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 165, 164, 164),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      'By ${news.author}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Published on ${news.publishedAt}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: (news.urlToImage != 'Not Found' &&
                                news.urlToImage.isNotEmpty &&
                                Uri.tryParse(news.urlToImage)?.hasAbsolutePath == true)
                            ? Image.network(
                                news.urlToImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      news.description,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      news.content,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child:
                        InkWell(
                          onTap: () {
                            openLink(context); 
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              'View Article',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ]),
            );
          },
        );
      },
    );
  }

  void openLink(BuildContext context) async {

    if(news.urlToImage != 'Not Found' && news.urlToImage.isNotEmpty && Uri.tryParse(news.urlToImage)?.hasAbsolutePath == true){
      if (await canLaunchUrl(Uri.tryParse(news.url)!)) {
        await launchUrl(Uri.tryParse(news.url)!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch')));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch')));
    }
  }
}

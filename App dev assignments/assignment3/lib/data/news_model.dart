class News{
  final String sourceID;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  News({
    required this.sourceID,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  });

  factory News.fromJson(Map<String,dynamic> json){ 
    return News(
      sourceID: json['source']['id']??'Not Found', 
      sourceName: json['source']['name']??'Unknown',
      author: json['author']??'Unknown Author', 
      title: json['title']??'Not Found', 
      description: json['description']??'Not Found', 
      url: json['url']??'Not Found', 
      urlToImage: json['urlToImage']??'Not Found', 
      publishedAt: json['publishedAt']??'Unknown', 
      content: json['content']??'Not Found'
    );
  }

}

/*
{
            "source": {
                "id": null,
                "name": "Gizmodo.com"
            },
            "author": "Thomas Maxwell",
            "title": "Elon Musk ‘Doesn’t Know How to Make a Battery,’ Rival Says",
            "description": "Robin Zeng, founder and chairman of CATL, says Musk's 4860 battery design \"is going to fail and never be successful.\"",
            "url": "https://gizmodo.com/elon-musk-doesnt-know-how-to-make-a-battery-rival-says-2000525007",
            "urlToImage": "https://gizmodo.com/app/uploads/2024/11/GettyImages-2171769626.jpg",
            "publishedAt": "2024-11-15T15:35:23Z",
            "content": "The founder and chairman of CATL, one of the world’s largest suppliers of batteries, says Elon Musk’s 4860 battery technology will never be successful. Robin Zeng made the comments in an interview wi… [+2565 chars]"
        }
*/
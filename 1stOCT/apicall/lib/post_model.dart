class Post {
  final int id;
  final String slug;
  final String content;
  final String url;
  final String image;
  final String title;

  Post({ //constructor
    required this.id,
    required this.slug,
    required this.image,
    required this.content,
    required this.url,
    required this.title,
  }); 

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      id: json['id'],
      slug: json['slug'],
      url: json['url'],
      content: json['content'],
      image: json['slug'],
      title: json['title']
    );
  }
}

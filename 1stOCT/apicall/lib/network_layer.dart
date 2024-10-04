import 'package:http/http.dart' as http;

Future<void> fetchAllPosts(String URL) async {
    //decodes json http response to Post model that we created below
    // https://jsonplaceholder.org/posts
    final response = await http.get(Uri.parse(URL));
    if(response.statusCode == 200){
      List jsonResponse = jsonDecode(response.body);
    }

    // try {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   final response =
    //       await http.get(Uri.parse('https://jsonplaceholder.org/posts'));
    //   if (response.statusCode == 200) {
    //     //all okay data araha api say
    //     List jsonResponse = jsonDecode(response.body);
    //     _post = jsonResponse.map((post) => Post.fromJson(post)).toList();
    //   } else {}
    // } catch (e) {
    //   throw Exception('Failed to load posts');
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }

  }
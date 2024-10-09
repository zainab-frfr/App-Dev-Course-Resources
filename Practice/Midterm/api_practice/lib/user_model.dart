class User{
  final String name;
  final String email; 
  final String thumbnail; 
  final int age; 

  User({
    required this.name,
    required this.email,
    required this.thumbnail,
    required this.age
  });

  factory User.fromJson(Map<String, dynamic> users){
    return User(
      name: '${users['name']['title']} ${users['name']['first']} ${users['name']['last']}', 
      email: users['email'], 
      thumbnail: users['picture']['thumbnail'],
      age: users['dob']['age']
    );
  }


}
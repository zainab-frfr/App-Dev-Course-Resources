class Jobs {
  final String network;
  final String jobTitle; 
  final String company; 
  final String location;
  final String onsiteOrHybrid; 
  final String partOrFullTime;
  final String daysPassed;

  Jobs(
    {
      required this.network, 
      required this.jobTitle, 
      required this.company, 
      required this.location, 
      required this.onsiteOrHybrid, 
      required this.partOrFullTime,
      required this.daysPassed
    }
  );
  
  factory Jobs.fromJson(Map<String,dynamic> json){ 
    var jobObject = json['job'];
    String posted = timePassed(jobObject['created_date']);
    return Jobs(
      network: jobObject['company']['logo'],
      jobTitle: jobObject['title'],
      company: jobObject['company']['name'],
      location: jobObject['location']['name_en'],
      onsiteOrHybrid: jobObject['workplace_preference']['name_en'],
      partOrFullTime: jobObject['type']['name_en'],
      daysPassed: posted
    );
  }
}

String timePassed(String dateCreated) {
  Duration dur = DateTime.now().difference(DateTime.parse(dateCreated));

  int days = dur.inDays;
  if (days == 1){
    return '1 day ago';
  }else if (days < 30){
    return '$days days ago';
  }else if (days >= 30 && days <= 45){
    return '1 month ago';
  }else {
    return '${(days/30).round()} months ago';
  }
}
class SaveItem{
  final String title;
  final String descp;
  final String link;

  SaveItem({
    required this.title,
    required this.descp,
    required this.link,
  });

  Map<String, dynamic> mapStudent() {
    return {
      'title': title,
      'descp': descp,
      'link': link,
    };
  }
}





































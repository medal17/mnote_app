class Note{
  int id;
  String title;
  String contents;

  Note({
    this.id,
    this.title,
    this.contents
});

  factory Note.fromJson(Map<String, dynamic> json)=> new Note(
    id: json["id"],
    title: json["title"],
    contents: json["contents"],
  );

  Map<String, dynamic> toJson() =>{
      "id" : id,
      "title":title,
      "contents":contents,
  };
}
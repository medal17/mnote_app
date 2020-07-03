class Todo{
  int id;
  String title;
  String subTasks;

  Todo({
    this.id,
    this.title,
    this.subTasks
  });

  factory Todo.fromJson(Map<String, dynamic> json)=> new Todo(
    id: json["id"],
    title: json["title"],
    subTasks: json["subTasks"],
  );

  Map<String, dynamic> toJson() =>{
    "id" : id,
    "title":title,
    "subTasks":subTasks,
  };
}
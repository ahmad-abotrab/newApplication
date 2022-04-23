class Tasks {
  String id;
  String title;
  DateTime dateTask;
  String priority;
  int status;

  Tasks({this.title, this.dateTask, this.priority, this.status});
  Tasks.withId({this.id, this.title, this.dateTask, this.priority, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = dateTask.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;
    return map;
  }

  factory Tasks.fromMap(Map<String, dynamic> map) {
    return Tasks.withId(
        id: map['id'],
        title: map['title'],
        dateTask: DateTime.parse(map['date']),
        priority: map['priority'],
        status: map['status']);
  }
}

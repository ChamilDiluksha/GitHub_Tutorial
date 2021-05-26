class Gitmodel {
  static const gittable = 'gitcommands';
  static const colId = 'id';
  static const colCommand = 'command';
  static const colDescription = 'description';

  Gitmodel({this.id, this.command, this.description});
  int id;
  String command;
  String description;

  /* convert the map object to git object  - to retrive*/
  Gitmodel.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    command = map[colCommand];
    description = map[colDescription];
  }

  /* convert the git object to map object - to insert*/
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colCommand: command,
      colDescription: description
    };
    if (id != null) map[colId] = id;
    return map;
  }
}

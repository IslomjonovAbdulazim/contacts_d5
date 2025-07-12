class ContactModel {
  // members
  late String name;
  late String tel;
  late String id;

  // constructor
  ContactModel({
    required this.name,
    required this.tel,
    required this.id,
  });

  // fromJson = import
  ContactModel.fromJson(Map json) {
    name = json["name"];
    tel = json["tel"];
    id = json["id"];
  }

  // toJson = export
  Map toJson() => {
    "name": name,
    "tel": tel,
    "id": id,
  };
}

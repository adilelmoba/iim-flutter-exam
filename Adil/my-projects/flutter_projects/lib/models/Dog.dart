class Dog {
  int? id; // Ce sera potentiellement null pour un nouveau chien
  String name;
  int age;

  Dog({this.id, required this.name, required this.age});
}

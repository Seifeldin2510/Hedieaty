class userModel {
  int id;
  String firstName;
  String lastName;
  int age;
  String email;
  String username;
  String password;
  String image;
  int eventNumber;

  userModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.username,
    required this.password,
    required this.image,
    this.eventNumber = 0,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
    "email": email,
    "username": username,
    "password": password,
    "image": image,
  };

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      age: json["age"],
      email: json["email"],
      username: json["username"],
      password: json["password"],
      image: json["image"],
    );}

}

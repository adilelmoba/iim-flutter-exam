class User {
  final int? userID;
  final String? userName;
  final String? userPassword;

  User({
    this.userID,
    this.userName,
    this.userPassword,
  });

  // Convertir un User en Map
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'userPassword': userPassword,
    };
  }

  // Créer un User à partir d'une Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'],
      userName: map['userName'],
      userPassword: map['userPassword'],
    );
  }

  @override
  String toString() {
    return 'User(userID: $userID, userName: $userName, userPassword: $userPassword)';
  }
}

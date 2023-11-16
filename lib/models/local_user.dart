class LocalUser{

  final String name;
  final String email;
  final String faculty;
  final bool isStudent;

  LocalUser({ required this.name, required this.email, required this.faculty, required this.isStudent });

  factory LocalUser.fromJson(Map<String, dynamic> json){
    return LocalUser(
      name: json['name'],
      email: json['email'],
      faculty: json['faculty'],
      isStudent: json['isStudent']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'faculty': faculty,
      'isStudent': isStudent
    };
  }

  @override
  String toString() {
    return 'LocalUser{name: $name, email: $email, faculty: $faculty}, isStudent: $isStudent';
  }
}
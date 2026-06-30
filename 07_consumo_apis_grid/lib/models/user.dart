class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String city;
  final String companyName;
  final String companyCatchPhrase;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.city,
    required this.companyName,
    required this.companyCatchPhrase,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      city: json['address']['city'] as String,
      companyName: json['company']['name'] as String,
      companyCatchPhrase: json['company']['catchPhrase'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'address': {
        'city': city,
      },
      'company': {
        'name': companyName,
        'catchPhrase': companyCatchPhrase,
      },
    };
  }
}

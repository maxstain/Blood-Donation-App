class UserData {
  final String uid;
  final String displayName;
  final String email;
  final String password;
  final String photoUrl;
  final String bio;
  final String city;
  final String country;
  final int donated;
  final int received;
  final DateTime createdAt;

  UserData({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.password,
    required this.photoUrl,
    required this.bio,
    required this.city,
    required this.country,
    required this.donated,
    required this.received,
    required this.createdAt,
  });

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      uid: data['uid'],
      displayName: data['displayName'],
      email: data['email'],
      password: data['password'],
      photoUrl: data['photoUrl'],
      bio: data['bio'],
      city: data['city'],
      country: data['country'],
      donated: data['donated'],
      received: data['received'],
      createdAt: data['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'bio': bio,
      'city': city,
      'country': country,
      'donated': donated,
      'received': received,
      'createdAt': createdAt,
    };
  }

  UserData copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? password,
    String? photoUrl,
    String? bio,
    String? city,
    String? country,
    int? donated,
    int? received,
    DateTime? createdAt,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      city: city ?? this.city,
      country: country ?? this.country,
      donated: donated ?? this.donated,
      received: received ?? this.received,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // An empty user data object
  static UserData empty = UserData(
    uid: '',
    displayName: '',
    email: '',
    password: '',
    photoUrl: '',
    bio: '',
    city: '',
    country: '',
    donated: 0,
    received: 0,
    createdAt: DateTime.now(),
  );
}

class AppUser {
  final String id;
  final String? firstname;
  final String? lastname;
  final String? gender;
  final bool? married;
  final bool? isSamaritan;
  final String? occupation;
  final double? age;
  final double? totalMonthlyIncome;
  final String? profilePicture;
  final String? countryOfResidence;
  final String? cityOfResidence;
  final String? nationality;

  AppUser(
      {this.id = '',
      this.gender,
      this.married,
      this.isSamaritan,
      this.occupation,
      this.age,
      this.totalMonthlyIncome,
      this.profilePicture,
      this.countryOfResidence,
      this.cityOfResidence,
      this.nationality,
      this.firstname,
      this.lastname});

  Map<String, dynamic> toJSON() => {
        'id': id,
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        'married': married,
        'isSamaritan': isSamaritan,
        'occupation': occupation,
        'age': age,
        'totalMonthlyIncome': totalMonthlyIncome,
        'profilePicture': profilePicture,
        'countryOfResidence': countryOfResidence,
        'cityOfResidence': cityOfResidence,
        'nationality': nationality,
      };

  static AppUser fromJSON(Map<String, dynamic> data) => AppUser(
        id: data['id'],
        firstname: data['firstname'],
        lastname: data['lastname'],
        gender: data['gender'],
        married: data['married'],
        isSamaritan: data['isSamaritan'],
        occupation: data['occupation'],
        age: data['age'],
        totalMonthlyIncome: data['totalMonthlyIncome'],
        profilePicture: data['profilePicture'],
        countryOfResidence: data['countryOfResidence'],
        cityOfResidence: data['cityOfResidence'],
        nationality: data['nationality'],
      );
}

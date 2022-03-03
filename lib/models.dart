class User {
  final int? id;
  final String login;
  final String password;
  final String address;
  final String phone;
  final String name;
  final int email;
  final String gender;
  final String firstname;
  final String secondname;
  final String thirdname;
  final String born;

  User({
    this.id,
    required this.login,
    required this.password,
    required this.address,
    required this.phone,
    required this.name,
    required this.email,
    required this.gender,
    required this.firstname,
    required this.secondname,
    required this.thirdname,
    required this.born
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'password': password,
      'address': address,
      'phone': phone,
      'name': name,
      'email': email,
      'gender': gender,
      'firstname': firstname,
      'secondname': secondname,
      'thirdname': thirdname,
      'born': born,
    };
  }

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        login = res["login"],
        password = res["password"],
        address = res["address"],
        phone = res["phone"],
        name = res["name"],
        email = res["email"],
        gender = res["gender"],
        firstname = res["firstname"],
        secondname = res["secondname"],
        thirdname = res["thirdname"],
        born = res["born"];

}

class Amount {
  final int? id;
  final String provider;
  final String number;
  final String status;
  final int email;
  final String datetime;
  final int cost;
  final int user;

  Amount({
    this.id,
    required this.provider,
    required this.number,
    required this.status,
    required this.email,
    required this.datetime,
    required this.cost,
    required this.user
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'provider': provider,
      'number': number,
      'status': status,
      'email': email,
      'datetime': datetime,
      'cost': cost,
      'user': user
    };
  }

  Amount.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        provider = res["provider"],
        number = res["number"],
        status = res["status"],
        email = res["email"],
        datetime = res["datetime"],
        cost = res["cost"],
        user = res["user"];

}

enum Gender {
  none,
  male,
  female
}
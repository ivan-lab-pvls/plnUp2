class UserItem {
  int? money;

  UserItem({this.money});

  factory UserItem.fromJson(Map<String, dynamic> parsedJson) {
    return UserItem(
      money: parsedJson['money'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'money': money,
    };
  }
}

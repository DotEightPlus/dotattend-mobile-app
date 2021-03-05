class UserData {
  String uid;
  String name;
  String email;
  String username;
  String profilePhoto;
  String password;
  String matricNo;
  String gender;
  String phoneNo;


  UserData({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.profilePhoto,
    this.password,
    this.gender,
    this.matricNo,
    this.phoneNo,
    
    
  });

  Map toMap(UserData user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["profile_photo"] = user.profilePhoto;
    data["password"] = user.password;
    data["gender"] = user.gender;
    data["matricNo"] = user.matricNo;
    data["phoneNo"] = user.phoneNo;
    return data;
  }

  // Named constructor
  UserData.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
    this.matricNo = mapData['matricNo'];
    this.password = mapData['password'];
    this.gender = mapData['gender'];
    this.phoneNo = mapData['phoneNo'];
  }
}

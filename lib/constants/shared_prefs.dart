import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager extends GetxController {
  //  late SharedPreferences prefs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString imageUrl = "".obs;
  RxString uid = "".obs;

  RxMap userMap = {}.obs;
  RxList<String>? userList;

  Future setuserlist() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("userlist", userList!);
        return prefs;
  }


  Future<void> getAccountObject() async {
    name.value = (await getName())!;
    email.value = (await getEmail())!;
    imageUrl.value = (await getImageURL())!;
    uid.value = (await getUid())!;
    // print("getname");
    // print(name);
  }

  Future<Map> getUserData() async {
    userMap.value = {
      "name": (await getName())!,
      "email": (await getEmail())!,
      "imageUrl": (await getImageURL())!,
      "uid": (await getUid())!,
    };
    return userMap;
  }
}

Future<void> setLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('logged_in', true);
}

Future<bool?> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("logged_in");
}

Future<void> removeLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("logged_in");
  prefs.remove("name");
  prefs.remove("email");
  prefs.remove("uid");
  prefs.remove("imageURL");
}

Future<void> setAccountObject({name, email, uid, imageURL}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
  prefs.setString('email', email);
  prefs.setString('uid', uid);
  prefs.setString('imageURL', imageURL);
  // print("name");
  // print(prefs.getString('name'));
}

Future<String?> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("name");
}

Future<String?> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("email");
}

Future<String?> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("uid");
}

Future<String?> getImageURL() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("imageURL");
}

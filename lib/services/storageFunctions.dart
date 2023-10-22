import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String initScreen = '';
const String authToken = "authToken";
const String profile = "profileInfo";
const String firebaseToken = "firebaseToken";
const String appleCred="appleCred";
const String userCred="userCred";
const String twoFADone="twoFADone";

class StorageFunctions {
  final _storage = const FlutterSecureStorage();

  Future<Map<String, String>> _readAll() async {
    var map = <String, String>{};
    try {
      map = await _storage.readAll(
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      print(e);
    }
    return map;
  }

  Future<void> deleteAllValue({reInstall=false}) async {
    print("----------$reInstall");
    var tempFCM = await StorageFunctions().getValue(firebaseToken);
    var cred= await StorageFunctions().getValue(appleCred);
    var users= await StorageFunctions().getValue(userCred);
    try {
      await _storage.deleteAll(
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
      await StorageFunctions().setValue(
        firebaseToken,
        tempFCM,
      );
      await StorageFunctions()
          .setValue(
        appleCred,
        cred,
      );
      if(!reInstall){
        await StorageFunctions()
            .setValue(
          userCred,
          users,
        );
      }
    } catch (e) {
      print(e);
    }
  }


  Future<String> getValue(key) async {
    String? value = "";
    try {
      value = await _storage.read(key: key);
    } catch (e) {
      print(e);
    }
    return value ?? "";
  }

  Future<void> deleteValue(key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setValue(key, value) async {
    print("$key---$value");
    try {
      await _storage.write(
        key: key,
        value: value,
      );
    } catch (e) {
      print("eRRROROORO Write-----$e");
    }
  }

  IOSOptions _getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}

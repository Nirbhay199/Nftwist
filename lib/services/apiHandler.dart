import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nftwist/services/storageFunctions.dart';

import '../constant/apiConstant.dart';
import "package:path/path.dart";
import 'package:http_parser/src/media_type.dart';
import "package:async/src/delegate/stream.dart";

int authUser=0;

enum REQUEST_TYPE {
  GET,
  POST,
  PATCH,
  PUT,
  DELETE,
}

Future<dynamic> httpRequest(REQUEST_TYPE requestType, String url, dynamic data) async {
  data = jsonEncode(data);
  late http.Response value;
  String token =  await StorageFunctions().getValue(authToken);
  print("-token-------$token");
  print("$baseUrl$url   ,send Data-$data");
  // debugger();
  try {
    final result = await InternetAddress.lookup('google.com');
    print(result[0].rawAddress);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      switch (requestType) {
        case REQUEST_TYPE.GET:
          value=await  http.get(
            Uri.parse("$baseUrl$url"),
            headers:{
              // HttpHeaders.contentTypeHeader: "application/json",
              'Content-Type': 'application/json; charset=UTF-8',
              HttpHeaders.authorizationHeader: token,
              // 'token': token,
              // HttpHeaders.authorizationHeader: 'Bearer $token',

            },
          );
          break;
        case REQUEST_TYPE.POST:
          value=await  http.post(
              Uri.parse("$baseUrl$url"),
              headers: (token == null) ? {
                HttpHeaders.contentTypeHeader: "application/json"
              } : {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader: token,
                // 'token': token,
                // HttpHeaders.authorizationHeader: 'Bearer $token',

              },
              body: data);
          break;
        case REQUEST_TYPE.PUT:
          value=await  http.put(
            Uri.parse("$baseUrl$url"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader:  token,
              // 'token': token,
              // HttpHeaders.authorizationHeader: 'Bearer $token',

            },
            body: data,
          );
          break;
        case REQUEST_TYPE.DELETE:
          value=await  http.delete(
              Uri.parse("$baseUrl$url"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:  token,
                // 'token': token,
                // HttpHeaders.authorizationHeader: 'Bearer $token',

              },
              body: data
          );
          break;
      case REQUEST_TYPE.PATCH:
          value=await  http.patch(
              Uri.parse("$baseUrl$url"),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:  token,
                // "Authorization": "Bearer $token"
                // 'token': token,
                // HttpHeaders.authorizationHeader: 'Bearer $token',

              },
            body: data,);
          break;
      }
    }
     // print("----- ------ print response data - - -- - - - -----\n \n           ${value.body} \n   . "  );
    if(value.statusCode==403&&authUser==0){
      authUser=1;

    }else{
      authUser=0;
      return value;
    }
  } on SocketException catch (_) {
    return http.Response(jsonEncode({"error":"bad_request","error_description":"Please connect to Internet"}), 400);
  }
}

Future<dynamic> uploadRequest(file,{type,ext}) async {
  print(file);
  var fle = File(file);
  // var img = Image(image: FileImage(File(file))); //file(new File(file);

  var stream = http.ByteStream(DelegatingStream.typed(fle.openRead()));
  var length = await fle.length();

  var uri = Uri.parse('$baseUrl$postImageUrl');

  var request = http.MultipartRequest("POST", uri);
  print(request);
   String token = await StorageFunctions().getValue(authToken);
  var multipartFile = http.MultipartFile('file', stream, length, filename: basename(fle.path), contentType: MediaType(type??'image', ext??'jpg'));
  request.files.add(multipartFile);
  request.headers.addAll({
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader:  token,
    // 'Bearer': token,
  });
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  Map jsonData=jsonDecode(responseString);
  return jsonData['data']['file_name'];
}


Future<List<String>> getDeviceDetails() async {
  String deviceName = "";
  String deviceVersion = "";
  String identifier = "";
  String deviceType = "";
  final DeviceInfoPlugin deviceInfoPlugin =  DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.id ;  //UUID for Android
      deviceType = "Android";
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name ?? "";
      deviceVersion = data.systemVersion ?? "";
      identifier = data.identifierForVendor ?? "";  //UUID for iOS
      deviceType = "iOS";
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

  //if (!mounted) return;
  return [deviceName, deviceVersion, identifier, deviceType];
}

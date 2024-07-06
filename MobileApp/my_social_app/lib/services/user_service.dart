import 'dart:convert';
import 'dart:typed_data';
import 'package:my_social_app/constants/controllers.dart';
import 'package:my_social_app/constants/user_endpoints.dart';
import 'package:my_social_app/models/user.dart';
import 'package:my_social_app/services/http/http_service.dart';

class UserService{
  final HttpService _httpService;
  
  UserService._(this._httpService);
  static final UserService _singleton = UserService._(HttpService());
  factory UserService() => _singleton;

  Future<void> makeFollowRequest(String requestedId) async {
    final body = jsonEncode(<String, String>{'requestedId': requestedId});
    String url = "$userController/$makeFollowRequestEndPoint";
    await _httpService.put(url, body: body);
  }

  Future<void> cancelFollowRequest(String requesterId) async {
    final body = jsonEncode(<String, String>{'requesterId': requesterId});
    String url = "$userController/$cancelFollowRequestEndPoint";
    await _httpService.put(url, body: body);
  }

  Future<void> removeFollower(String followerId) async {
    final body = jsonEncode(<String,String>{'followerId': followerId});
    String url = "$userController/$removeFollowerEndPoint";
    await _httpService.put(url, body: body);
  }

  Future<User> get() async {
    String url = "$userController/$getUserEndPoint";
    return User.fromJson(await _httpService.get(url));
  }
 
  Future<User> getById(String id) async {
    final String url = "$userController/$getUserByIdEndPoint/$id";
    return User.fromJson(await _httpService.get(url));
  }

  Future<Uint8List> getImage() async {
    String url = "$userController/$getUserImageEndPoint";
    return await _httpService.readBytes(url);
  }

  Future<Uint8List> getImageById(String id) async {
    String url = "$userController/$gerUserImageByIdEndPoint/$id";
    return await _httpService.readBytes(url);
  }

  Future<List<User>> getFollowers({String? lastId}) async{
    String url = "$userController/$getFollowersEndPoint";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

  Future<List<User>> getFollowersById(String id, {String? lastId}) async {
    String url = "$userController/$getFollowersByIdEndPoint/$id";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

  Future<List<User>> getFolloweds({String? lastId}) async{
    String url = "$userController/$getFollowedsEndPoint";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

  Future<List<User>> getFollowedsById(String id, {String? lastId}) async {
    String url = "$userController/$getFollowedsByIdEndPoint/$id";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

  Future<List<User>> getRequesters({String? lastId}) async {
    String url = "$userController/$getRequestersEndPoint";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

  Future<List<User>> getRequesteds({String? lastId}) async {
    String url = "$userController/$getRequestedsEndPoint";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

  Future<List<User>> search(String key, {String? lastId}) async {
    String url = "$userController/$searchUserEndPoint/$key";
    return (await _httpService.getList(lastId != null ? "$url?lastId=$lastId" : url)).map(
      (item) => User.fromJson(item)
    ).toList();
  }

}
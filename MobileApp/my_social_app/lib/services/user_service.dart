import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:my_social_app/constants/controllers.dart';
import 'package:my_social_app/constants/user_endpoints.dart';
import 'package:my_social_app/models/follow.dart';
import 'package:my_social_app/models/user.dart';
import 'package:my_social_app/services/app_client.dart';
import 'package:my_social_app/state/pagination/page.dart';

class UserService{
  final AppClient _appClient;
  
  UserService._(this._appClient);
  static final UserService _singleton = UserService._(AppClient());
  factory UserService() => _singleton;

  Future<void> updateImage(XFile file) async {
    const url = "$userController/$updateUserImageEndpoint";
    final request = MultipartRequest("Post", _appClient.generateUri(url));
    request.files.add(await MultipartFile.fromPath("file",file.path));
    await _appClient.send(request);
  }

  Future<Uint8List> removeImage() => 
    _appClient
      .getBytes("$userController/$removeUserImageEndpoint");
  
  Future<void> updateName(String name) => 
    _appClient
      .put("$userController/$updateNameEndpoint",body: {'name' : name});
  
  Future<Follow> follow(int followedId) => 
    _appClient
      .post(
        "$userController/$followEndPoint",
        body: { 'followedId': followedId }
      )
      .then((json) => Follow.fromJson(json));

  Future<void> unfollow(int followedId) => 
    _appClient
      .delete("$userController/$unfollowEndPoint/$followedId");
  
  Future<void> removeFollower(int followerId) => 
    _appClient
      .delete("$userController/$removeFollowerEndPoint/$followerId");
    
  Future<void> addSearched(int searchedId) => 
    _appClient
      .post(
        "$userController/$addUserSearchedEndpoint",
        body: { 'searchedId': searchedId }
      );

  Future<void> removeSearched(int searchedId) => 
    _appClient.delete("$userController/$removeUserSearchedEndpoint/$searchedId");

  Future<User> getById(int id) => 
    _appClient
      .get("$userController/$getUserByIdEndPoint/$id")
      .then((json) => User.fromJson(json));

  Future<User> getByUserName(String userName) =>
    _appClient
      .get("$userController/$getUserByUserNameEndpoint/$userName")
      .then((json) => User.fromJson(json));
  
  Future<Uint8List> getImageById(int id) => 
    _appClient
      .getBytes("$userController/$gerUserImageByIdEndPoint/$id");
  
  Future<Iterable<User>> getFollowersById(int id, Page page) =>
    _appClient
      .get(_appClient.generatePaginationUrl("$userController/$getFollowersByIdEndPoint/$id", page))
      .then((json) => json as List)
      .then((list) => list.map((item) => User.fromJson(item)));
 
  Future<Iterable<User>> getFollowedsById(int id, Page page) =>
    _appClient
      .get(_appClient.generatePaginationUrl("$userController/$getFollowedsByIdEndPoint/$id", page))
      .then((json) => json as List)
      .then((list) => list.map((item) => User.fromJson(item)));

  Future<Iterable<User>> getNotFolloweds(int id, Page page) =>
   _appClient
    .get(_appClient.generatePaginationUrl("$userController/$getNotFollowedsEndpoint/$id", page))
    .then((json) => json as List)
    .then((list) => list.map((item) => User.fromJson(item)));

  Future<Iterable<User>> search(String key, Page page) =>
    _appClient
      .post(
        "$userController/$searchUserEndPoint",
        body: {
          'key': key,
          'offset': page.offset,
          'take': page.take,
          'isDescending': page.isDescending
        }
      )
      .then((json) => json as List)
      .then((list) => list.map((item) => User.fromJson(item)));

  Future<Iterable<User>> getSearcheds(Page page) =>
    _appClient
      .get(_appClient.generatePaginationUrl("$userController/$getSearchedsEndpoint",page))
      .then((json) => json as List)
      .then((list) => list.map((item) => User.fromJson(item)));
}
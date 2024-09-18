import 'dart:async';
import 'package:my_social_app/constants/account_endpoints.dart';
import 'package:my_social_app/constants/controllers.dart';
import 'package:my_social_app/models/account.dart';
import 'package:my_social_app/services/app_client.dart';

class AccountService {
  final AppClient _appClient;

  const AccountService._(this._appClient);
  static final AccountService _singleton = AccountService._(AppClient());
  factory AccountService() => _singleton;

  Future<Account> create(String email, String password, String passwordConfirmation) =>
    _appClient
      .post(
        "$accountController/$createEndPoint",
        body: {
          'email':email,
          'password':password,
          "passwordConfirm":passwordConfirmation
        }
      )
      .then((json) => Account.fromJson(json));

  Future<Account> updateEmailConfirmationToken() =>
    _appClient
      .post("$accountController/$updateEmailConfirmationTokenEndPoint")
      .then((json) => Account.fromJson(json));

  Future<Account> confirmEmailByToken(String token) =>
    _appClient
      .post(
        "$accountController/$confirmEmailByTokenEntPoint",
        body: { 'token': token }
      )
      .then((json) => Account.fromJson(json));

  Future<Account> loginByPassword(String emailOrUserName, String password) =>
    _appClient
      .post(
        "$accountController/$loginByPasswordEndPoint",
        body: { 'emailOrUserName':emailOrUserName, 'password':password }
      )
      .then((json) => Account.fromJson(json));
  
  Future<Account> loginByFaceBook(String accessToken) =>
    _appClient
      .post(
        "$accountController/$loginByFaceBookEndpoint",
        body: { 'accessToken': accessToken}
      )
      .then((json) => Account.fromJson(json));

  Future<Account> loginByReshtoken(int id,String token) =>
    _appClient
      .post(
        "$accountController/$loginByRefreshTokenEndPoint",
        body: { 'id': id.toString(),'token': token}
      )
      .then((json) => Account.fromJson(json));

  Future<Account> updateEmail(String email) =>
    _appClient
      .post(
        "$accountController/$updateEmailEndPoint",
        body: { 'email': email }
      )
      .then((json) => Account.fromJson(json));

  Future<Account> updateUserName(String userName) =>
    _appClient
      .post(
        "$accountController/$updateUserNameEndPoint",
        body: { 'userName': userName}
      )
      .then((account) => Account.fromJson(account));

  Future<void> logOut() =>
    _appClient
      .put("$accountController/$logOutEndPoint");

  Future<bool> isUserNameExist(String userName) =>
    _appClient
      .get("$accountController/$isUserNameExistEndPoint/$userName")
      .then((response) => response as bool);
}
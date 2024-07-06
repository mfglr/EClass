import 'dart:collection';
import 'package:my_social_app/providers/account_provider.dart';
import 'package:my_social_app/providers/search_state.dart';
import 'package:my_social_app/providers/user_state.dart';

class AppState{
  
  final Map<String,UserState> _users = {};
  UserState? getUser(String id) => _users[id];
  UnmodifiableListView<UserState> getFollowers(String id) => UnmodifiableListView(_users[id]!.followers.map((id) => _users[id]!));
  UnmodifiableListView<UserState> getFolloweds(String id) => UnmodifiableListView(_users[id]!.followeds.map((id) => _users[id]!));
  UnmodifiableListView<UserState> getRequesters() => UnmodifiableListView(_users[AccountProvider().state!.id]!.requesters.map((id) => _users[id]!));
  UnmodifiableListView<UserState> getRequesteds() => UnmodifiableListView(_users[AccountProvider().state!.id]!.requesteds.map((id) => _users[id]!));
  UnmodifiableListView<UserState> get usersSearched => UnmodifiableListView(_searchState.ids.map((id) => _users[id]!));

  SearchState _searchState = SearchState();
  SearchState get searchState => _searchState;
  String get key => _searchState.key;

  AppState _clone(){
    final AppState state = AppState();
    state._searchState = _searchState.clone();
    state._users.addEntries(_users.entries);
    return state;
  }

  AppState loadUser(UserState user){
    final AppState clone = _clone();
    clone._users.addEntries([MapEntry(user.id, user)]);
    return clone;
  }
  AppState loadFollowers(String id, List<UserState> users){
    final AppState clone = _clone();
    final uniqUsers = users.where((user) => _users[user.id] == null);
    clone._users.addEntries(uniqUsers.map((user) => MapEntry(user.id, user)));
    clone._users[id] = _users[id]!.loadFollowers(users.map((user) => user.id).toList());
    return clone;
  }
  AppState loadFolloweds(String id, List<UserState> users){
    final AppState clone = _clone();
    final uniqUsers = users.where((user) => _users[user.id] == null);
    clone._users.addEntries(uniqUsers.map((user) => MapEntry(user.id, user)));
    clone._users[id] = _users[id]!.loadFolloweds(users.map((user) => user.id).toList());
    return clone;
  }
  AppState loadRequesters(List<UserState> users){
    final AppState clone = _clone();
    final accountId = AccountProvider().state!.id;
    final uniqUsers = users.where((user) => _users[user.id] == null);
    clone._users.addEntries(uniqUsers.map((user) => MapEntry(user.id, user)));
    clone._users[accountId] = _users[accountId]!.loadRequesters(users.map((user) => user.id).toList());
    return clone;
  }
  AppState loadRequesteds(List<UserState> users){
    final AppState clone = _clone();
    final accountId = AccountProvider().state!.id;
    final uniqUsers = users.where((user) => _users[user.id] == null);
    clone._users.addEntries(uniqUsers.map((user) => MapEntry(user.id, user)));
    clone._users[accountId] = _users[accountId]!.loadRequesteds(users.map((user) => user.id).toList());
    return clone;
  }
  AppState makeFollowRequest(String requestedId){
    final AppState clone = _clone();
    final accountId = AccountProvider().state!.id;
    final requester = _users[accountId]!;//current user
    final requested = _users[requestedId]!;
    clone._users[accountId] = requester.addRequested(requestedId);
    clone._users[requestedId] = requested.addRequester(accountId);
    return clone;
  }
  AppState cancelFollowRequest(String requestedId){
    final AppState clone = _clone();
    final accountId = AccountProvider().state!.id;
    final requester = _users[accountId]!;//current user
    final requested = _users[requestedId]!;
    clone._users[accountId] = requester.removeRequested(requestedId);
    clone._users[requestedId] = requested.removeRequester(accountId);
    return clone;
  }
  AppState removeFollower(String followerId){
    final AppState clone = _clone();
    final accountId = AccountProvider().state!.id;
    final followed = _users[accountId]!;//current user
    final follower = _users[followerId]!;
    clone._users[accountId] = followed.removeFollower(followerId);
    clone._users[followerId] = follower.removeFollowed(accountId);
    return clone;
  }

  AppState initSearch(String key,List<UserState> users){
    final AppState clone = _clone();
    clone._users.addEntries(users.map((user) => MapEntry(user.id, user)));
    clone._searchState = _searchState.init(key, users.map((state) => state.id).toList());
    return clone;
  }

  AppState clearSearch(){
    final AppState clone = _clone();
    clone._searchState = _searchState.clear();
    return clone;
  }

}
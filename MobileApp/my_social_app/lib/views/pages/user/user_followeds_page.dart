import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:my_social_app/providers/app_provider.dart';
import 'package:my_social_app/providers/user_state.dart';
import 'package:my_social_app/views/loading_view.dart';
import 'package:my_social_app/views/shared/user/user_items_widget.dart';
import 'package:provider/provider.dart';

class UserFollowedsPage extends StatelessWidget {
  const UserFollowedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followings"),
      ),
      body: FutureBuilder(
        future: context.read<AppProvider>().loadFollowedsIfNoUsers(userId),
        builder: (context,snapshot) {
          switch(snapshot.connectionState){
            case(ConnectionState.done):
              return Container(
                margin: const EdgeInsets.all(5),
                child: Selector<AppProvider,UnmodifiableListView<UserState>>(
                  selector:  (_, userProvider) => userProvider.getFolloweds(userId),
                  builder: (_, value, __) =>UserItemsWidget(state : value),
                )
              );
            default:
              return const LoadingView();
          }
        } 
      )
    );
  }
}
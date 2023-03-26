import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:routemaster/routemaster.dart';

import '../../community/controller/community_controller.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunityScreen(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          ListTile(
            title: const Text("Create a community"),
            leading: const Icon(Icons.add),
            onTap: () => navigateToCreateCommunityScreen(context),
          ),
          ref.watch(userCommunityProvider).when(
              data: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                    final community = data[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(community.avater),
                      ),
                      onTap: (){},
                      title: Text("r/${community.name}"),
                    );
                  }),
                );
              },
              error: (error, stackTrace) {
                return ErrorText(text: error.toString());
              },
              loading: () => const Loader())
        ],
      )),
    );
  }
}

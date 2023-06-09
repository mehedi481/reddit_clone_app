import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/loader.dart';

import '../controller/community_controller.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(context, communityNameController.text.trim());
  }

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Create Community")),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Community name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: communityNameController,
                  decoration: const InputDecoration(
                    hintText: 'r/Community_name',
                    filled: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(18),
                  ),
                  maxLength: 21,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () => createCommunity(),
                  child: const Text("Create Community"),
                )
              ]),
            ),
    );
  }
}

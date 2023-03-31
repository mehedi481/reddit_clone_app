import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/common/error.dart';
import 'package:reddit_clone/core/common/loader.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/features/community/controller/community_controller.dart';
import 'package:reddit_clone/theme/pallete.dart';

import '../../../core/constants/constants.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  const EditCommunityScreen({
    required this.name,
  });
  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) {
            return Scaffold(
              backgroundColor: Pallete.darkModeAppTheme.backgroundColor,
              appBar: AppBar(
                title: const Text("Edit Community"),
                centerTitle: false,
                actions: [
                  TextButton(onPressed: () {}, child: const Text("Save"))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => selectBannerImage(),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          color: Pallete
                              .darkModeAppTheme.textTheme.bodyMedium!.color!,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: bannerFile != null
                                ? Image.file(
                                    bannerFile!,
                                    fit: BoxFit.cover,
                                  )
                                : community.banner.isEmpty ||
                                        community.banner ==
                                            Constants.bannerDefault
                                    ? const Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 40,
                                        ),
                                      )
                                    : Image.network(
                                        community.banner,
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        bottom: -20,
                        child: GestureDetector(
                          onTap: selectProfileImage,
                          child: profileFile != null
                              ? CircleAvatar(
                                  radius: 32,
                                  backgroundImage: FileImage(profileFile!),
                                )
                              : CircleAvatar(
                                  radius: 32,
                                  backgroundImage:
                                      NetworkImage(community.avater),
                                ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(text: error.toString()),
          loading: () => const Loader(),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/models/community_model.dart';
import 'package:routemaster/routemaster.dart';
import '../../../core/utils.dart';
import '../repository/community_repository.dart';


final userCommunityProvider = StreamProvider<List<CommunityModel>>((ref) {
  return ref.watch(communityControllerProvider.notifier).getUserCommunities();
});


final communityControllerProvider = StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(communityRepository: ref.watch(communityRepositoryProvider), ref: ref);
});


class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        super(false);

  void createCommunity(BuildContext context, String name) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    CommunityModel communityModel = CommunityModel(
      id: uid,
      name: name,
      banner: Constants.bannerDefault,
      avater: Constants.avatarDefault,
      members: [uid],
      mods: [uid],
    );
    final res = await _communityRepository.createCommunity(communityModel);

    state = false;

    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Community created successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<CommunityModel>> getUserCommunities() {
    final uid = _ref.read(userProvider)?.uid ?? '';
    return _communityRepository.getUserCommunities(uid);
  }
}

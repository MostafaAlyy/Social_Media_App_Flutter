import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/ViewModel/Cupits/SocialCupit/cupit.dart';

import '../PostsCupit/posts_cubit.dart';
part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsInitial());
  void onChange(Change<FeedsState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  static FeedsCubit get(BuildContext context) => BlocProvider.of(context);

  List<PostPair> posts = [];

  getPosts() {
    emit(GetPostsLoading());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        int? likes;
        element.reference.collection('likes').get().then((value) {
          likes = value.docs.length;
          posts.add(
              PostPair(PostModel.fromJson(element.data()), element.id, likes!));
          emit(GetPostsSuccess());
        }).catchError((onError) {
          emit(GetPostsError());
        });
      });
    }).catchError((onError) {
      emit(GetPostsError());
    });
  }

  likedPosts(String postId, BuildContext context) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection("likes")
        .doc(SocialCupit.get(context).user!.uId)
        .set({'likes': true}).then((value) {
      emit(LikePostsSuccess());
    }).catchError((onError) {
      emit(LikePostsError());
    });
  }
}

class PostPair {
  String? postId;
  PostModel? model;
  int? likes;
  PostPair(PostModel? model, String? postId, int likes) {
    this.likes = likes;
    this.model = model;
    this.postId = postId;
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/ViewModel/Cupits/SocialCupit/cupit.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
  static PostsCubit get(BuildContext context) => BlocProvider.of(context);
  void onChange(Change<PostsState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  final storage = FirebaseStorage.instance;
  TextEditingController newPostTextController = TextEditingController();

  var picker = ImagePicker();
  File? PostImage;

  getPostImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      PostImage = File(pickedImage.path);
      await uploadPostImage();
      emit(PostImageStateSuccess());
    } else {
      debugPrint("No Selected Image");
      emit(PostImageStateError());
    }
  }

  String? postImageUrl;
  uploadPostImage() {
    storage
        .ref()
        .child('users/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                postImageUrl = value;
                debugPrint(value);
                emit(UploadPostImageStateSuccess());
              }).catchError((onError) {
                emit(UploadPostImageStateError());
              })
            })
        .catchError((onError) {
      emit(UploadPostImageStateError());
    });
  }

  createNewPost(
    BuildContext context,
    String text,
    String dateTime,
  ) {
    emit(CreatePostsLoading());

    PostModel model = PostModel(
        name: SocialCupit.get(context).user!.name,
        image: SocialCupit.get(context).user!.image,
        uId: SocialCupit.get(context).user!.uId,
        dateTime: dateTime,
        text: text,
        postImage: postImageUrl);

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) async {
      emit(CreatePostsSuccess());
    }).catchError((onError) {
      emit(CreatePostsError());
    });
  }
}

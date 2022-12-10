// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/ViewModel/Cupits/SocialCupit/states.dart';

import '../../../View/Pages/chats/chats_scr.dart';
import '../../../View/Pages/feeds/feeds_scr.dart';
import '../../../View/Pages/post/post_scr.dart';
import '../../../View/Pages/setting/seetings_scr.dart';
import '../../../View/Pages/users/users_scr.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCupit extends Cubit<SocialAppStates> {
  SocialCupit() : super(SocialInitialStates());
  static SocialCupit get(BuildContext context) => BlocProvider.of(context);
  void onChange(Change<SocialAppStates> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  UserModel? user;

  Future getUserData(String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) async {
      user = UserModel.fromJson(value.data()!);
      emit(UserGetSuccessStates());
    }).catchError((error) {
      debugPrint(error.toString());

      emit(UserGetErrorStates());
    });
  }

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    emit(RegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          email: email,
          password: password,
          phone: phone,
          uId: value.user!.uid,
          name: name);
    }).catchError((onError) {
      emit(RegisterErrorStates());
    });
  }

  void userCreate(
      {required String email,
      required String password,
      required String phone,
      required String uId,
      required String name}) async {
    emit(UserCreateLoadingStates());

    user = UserModel(
        image:
            'https://st2.depositphotos.com/2777531/6975/v/450/depositphotos_69759195-stock-illustration-male-person-silhouette.jpg',
        email: email,
        name: name,
        cover:
            'https://st2.depositphotos.com/2777531/6975/v/450/depositphotos_69759195-stock-illustration-male-person-silhouette.jpg',
        password: password,
        phone: phone,
        uId: uId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user!.toMap())
        .then((value) {
      emit(UserCreateSuccessStates());
    }).catchError((onError) {
      print(onError.toString());
      emit(UserCreateErrorStates());
    });
  }

  void userLogin({required String email, required String password}) {
    emit(LOGINLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LOGINSuccessStates(value.user!.uid));
    }).catchError((onError) {
      print(onError.toString());
      emit(LOGINErrorStates());
    });
  }

  int currentindex = 0;
  List<Widget> screens = [
    FeedsScr(),
    ChatScr(),
    PostScr(),
    UsersScr(),
    SettingScr()
  ];
  List<String> titles = ["Home", "Chats", "Post", "Users", "Settings"];
  void ChangeBottomNAv(index) {
    currentindex = index;
    emit(BottomNavChangeStates());
  }

  TextEditingController nameController = TextEditingController();

  File? editProfileImage;
  var picker = ImagePicker();
  getProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      editProfileImage = File(pickedImage.path);
      emit(ProfileEditedStateSuccess());
    } else {
      debugPrint("No Selected Image");
      emit(ProfileEditedStateSuccess());
    }
  }

  File? editCoverImage;

  getCoverImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      editCoverImage = File(pickedImage.path);
      emit(CoverEditedStateSuccess());
    } else {
      debugPrint("No Selected Image");
      emit(CoverEditedStateError());
    }
  }

  final storage = FirebaseStorage.instance;
  String profileImageUrl = "", coverImageUrl = "";

  Future uploadProfileImage() async {
    storage
        .ref()
        .child('users/${Uri.file(editProfileImage!.path).pathSegments.last}')
        .putFile(editProfileImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                profileImageUrl = value;
                debugPrint(value);
                emit(UploadProfileEditedStateSuccess());
              }).catchError((onError) {})
            })
        .catchError((onError) {
      emit(UploadProfileEditedStateError());
    });
  }

  uploadCoverImage() async {
    storage
        .ref()
        .child('users/${Uri.file(editCoverImage!.path).pathSegments.last}')
        .putFile(editCoverImage!)
        .then((value) => {
              value.ref.getDownloadURL().then((value) {
                coverImageUrl = value;
                debugPrint(value);
                emit(UploadCoverEditedStateSuccess());
              }).catchError((onError) {})
            })
        .catchError((onError) {
      emit(UploadCoverEditedStateError());
    });
  }

  updateUserData(String name, String profileImage, String cover) {
    UserModel model = UserModel(
      name: name,
      cover: user!.cover,
      email: user!.email,
      image: user!.image,
      phone: user!.phone,
      password: user!.password,
      uId: user!.uId,
    );
    if (editCoverImage != null) {
      uploadCoverImage();
      model.cover = cover;
    }
    if (editProfileImage != null) {
      uploadProfileImage();
      model.image = profileImage;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .update(model.toMap())
        .then((value) async {
      getUserData(user!.uId);
    }).catchError((onError) {
      emit(UpdateDataStateError());
    });
  }
}

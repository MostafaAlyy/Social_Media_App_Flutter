import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/MessageModel.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/ViewModel/Cupits/SocialCupit/cupit.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());
  static ChatsCubit get(BuildContext context) => BlocProvider.of(context);
  void onChange(Change<ChatsState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  TextEditingController messageTypingController = TextEditingController();

  List<UserModel> users = [];

  getUsers() {
    emit(GetUsersLoading());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });
      print(users.length);
      emit(GetUsersSuccess());
    }).catchError((onError) {
      emit(GetUsersError());
    });
  }

  sendMessage({
    required String text,
    required String dateTime,
    required String receiverId,
    required BuildContext context,
  }) {
    emit(SendMessagesLoading());
    MessageModel message = MessageModel(
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: SocialCupit.get(context).user!.uId,
        text: text);
    FirebaseFirestore.instance
        .collection('users')
        .doc(SocialCupit.get(context).user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection("Messages")
        .add(message.toMap())
        .then((value) {
      emit(SendMessagesSuccess());
    }).catchError((onError) {
      emit(SendMessagesError());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(SocialCupit.get(context).user!.uId)
        .collection("Messages")
        .add(message.toMap())
        .then((value) {
      emit(SendMessagesSuccess());
    }).catchError((onError) {
      emit(SendMessagesError());
    });
  }

  List<MessageModel> messages = [];
  getMessages(String receiverId, BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(SocialCupit.get(context).user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('Messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccess());
    });
  }
}

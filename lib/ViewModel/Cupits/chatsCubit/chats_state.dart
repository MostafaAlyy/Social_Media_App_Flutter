part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

//get users
class GetUsersLoading extends ChatsState {}

class GetUsersSuccess extends ChatsState {}

class GetUsersError extends ChatsState {}

//get messages
class GetMessagesLoading extends ChatsState {}

class GetMessagesSuccess extends ChatsState {}

class GetMessagesError extends ChatsState {}

//send message
class SendMessagesLoading extends ChatsState {}

class SendMessagesSuccess extends ChatsState {}

class SendMessagesError extends ChatsState {}

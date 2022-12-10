part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

//create post states
class CreatePostsLoading extends PostsState {}

class CreatePostsSuccess extends PostsState {}

class CreatePostsError extends PostsState {}

//get post image states
class PostImageStateSuccess extends PostsState {}

class PostImageStateError extends PostsState {}

//upload post states
class UploadPostImageStateSuccess extends PostsState {}

class UploadPostImageStateError extends PostsState {}

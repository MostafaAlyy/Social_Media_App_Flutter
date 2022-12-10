part of 'feeds_cubit.dart';

@immutable
abstract class FeedsState {}

class FeedsInitial extends FeedsState {}

//get posts
class GetPostsLoading extends FeedsState {}

class GetPostsSuccess extends FeedsState {}

class GetPostsError extends FeedsState {}

//like post
class LikePostsSuccess extends FeedsState {}

class LikePostsError extends FeedsState {}

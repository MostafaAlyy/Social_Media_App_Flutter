abstract class SocialAppStates {}

class SocialInitialStates extends SocialAppStates {}

//Register states
class RegisterLoadingStates extends SocialAppStates {}

class RegisterSuccessStates extends SocialAppStates {}

class RegisterErrorStates extends SocialAppStates {}

//LOGIN states
class LOGINSuccessStates extends SocialAppStates {
  final String uId;
  LOGINSuccessStates(this.uId);
}

class LOGINErrorStates extends SocialAppStates {}

class LOGINLoadingStates extends SocialAppStates {}

//UserCreate states
class UserCreateSuccessStates extends SocialAppStates {}

class UserCreateErrorStates extends SocialAppStates {}

class UserCreateLoadingStates extends SocialAppStates {}

//bottnav
class BottomNavChangeStates extends SocialAppStates {}

//UserCreate states

class UserGetSuccessStates extends SocialAppStates {}

class UserGetErrorStates extends SocialAppStates {}

//Edit Images states
class ProfileEditedStateSuccess extends SocialAppStates {}

class ProfileEditedStateError extends SocialAppStates {}

class CoverEditedStateSuccess extends SocialAppStates {}

class CoverEditedStateError extends SocialAppStates {}

//Upload Images states
class UploadProfileEditedStateSuccess extends SocialAppStates {}

class UploadProfileEditedStateError extends SocialAppStates {}

class UploadCoverEditedStateSuccess extends SocialAppStates {}

class UploadCoverEditedStateError extends SocialAppStates {}

//Update user data states

class UpdateDataStateSuccess extends SocialAppStates {}

class UpdateDataStateError extends SocialAppStates {}

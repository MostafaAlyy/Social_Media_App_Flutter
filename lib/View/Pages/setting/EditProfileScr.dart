import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/View/Components/Setting%20components/SettingCompo.dart';

import '../../../ViewModel/Cupits/SocialCupit/cupit.dart';
import '../../../ViewModel/Cupits/SocialCupit/states.dart';

class EditProfileScr extends StatelessWidget {
  EditProfileScr({super.key});

  @override
  Widget build(BuildContext context) {
    SocialCupit.get(context).nameController.text =
        SocialCupit.get(context).user!.name!;
    return BlocConsumer<SocialCupit, SocialAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cupit = SocialCupit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Edit Profile',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextButton(
                  onPressed: () {
                    cupit.updateUserData(cupit.nameController.text,
                        cupit.profileImageUrl, cupit.coverImageUrl);
                  },
                  child: const Text('Update',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                          clipBehavior: Clip.hardEdge,
                          child: (cupit.editCoverImage == null)
                              ? Image.network(
                                  cupit.user!.cover!,
                                  cacheHeight: 300,
                                  cacheWidth: 600,
                                )
                              : Image(
                                  image: FileImage(cupit.editCoverImage!),
                                  height: 300,
                                  width: 600,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[700],
                              child: IconButton(
                                onPressed: () {
                                  cupit.getCoverImage();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.camera,
                                ),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CircleAvatar(
                                    maxRadius: 64,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      backgroundImage: cupit.editProfileImage ==
                                              null
                                          ? NetworkImage(cupit.user!.image!)
                                              as ImageProvider
                                          : FileImage(cupit.editProfileImage!)
                                              as ImageProvider,
                                      maxRadius: 60,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[700],
                                    child: IconButton(
                                      onPressed: () {
                                        cupit.getProfileImage();
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.camera,
                                      ),
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EditTextFormField(
                        controller: cupit.nameController,
                        validateString: "Please enter Name",
                        label: "Name")),
                const SizedBox(
                  height: 10,
                ),

                /*  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EditTextFormField(
                        controller: cupit.nameController,
                        validateString: "Please enter phone",
                        label: "phone")),
                const SizedBox(
                  height: 10,
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}

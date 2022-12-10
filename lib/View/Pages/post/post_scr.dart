import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/ViewModel/Cupits/SocialCupit/states.dart';

import '../../../ViewModel/Cupits/PostsCupit/posts_cubit.dart';
import '../../../ViewModel/Cupits/SocialCupit/cupit.dart';

class PostScr extends StatelessWidget {
  const PostScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();

    return BlocProvider(
      create: (context) => PostsCubit(),
      child: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = PostsCubit.get(context);
          return ConditionalBuilder(
              condition: (state is CreatePostsLoading),
              builder: ((context) =>
                  Center(child: CircularProgressIndicator())),
              fallback: ((context) => Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      SocialCupit.get(context).user!.image!),
                                  maxRadius: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${SocialCupit.get(context).user!.name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(now.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey)),
                                  ],
                                ),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {
                                      cupit.createNewPost(
                                          context,
                                          cupit.newPostTextController.text,
                                          now.toString());
                                    },
                                    child: const Text("POST",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: cupit.newPostTextController,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      hintText: "What's on your mind ...",
                                      border: InputBorder.none),
                                ),
                                if (cupit.PostImage != null)
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      elevation: 10,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: FileImage(cupit.PostImage!)),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    cupit.getPostImage();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(FontAwesomeIcons.image),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Add photo",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )),
                              TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(FontAwesomeIcons.tag),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("tags",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ))
                            ],
                          )
                        ]),
                  )));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Models/PostModel.dart';
import 'package:social_app/ViewModel/Cupits/SocialCupit/cupit.dart';
import 'package:social_app/ViewModel/Cupits/feedsCubit/feeds_cubit.dart';

import '../../../Models/UserModel.dart';

Widget BuildPost(context, PostModel model, int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      maxRadius: 25,
                      backgroundImage: NetworkImage(model.image!),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(model.name!),
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 20,
                            )
                          ],
                        ),
                        Text(
                          model.dateTime!,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    model.text!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                if (model.postImage != null)
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: 10,
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(model.postImage!)),
                    ),
                  ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.heartCirclePlus,
                            color: Color.fromARGB(255, 207, 47, 47),
                            size: 16,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      " ${FeedsCubit.get(context).posts[index].likes}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Spacer(),
                    Container(
                      width: 20,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.commentDots,
                            color: Colors.orange,
                            size: 16,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1000 Comment",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 18,
                      backgroundImage:
                          NetworkImage(SocialCupit.get(context).user!.image!),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16)),
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Text('write a comment'),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 20,
                      child: IconButton(
                          onPressed: () {
                            FeedsCubit.get(context).likedPosts(
                                FeedsCubit.get(context).posts[index].postId!,
                                context);
                          },
                          icon: Icon(
                            FontAwesomeIcons.heartCirclePlus,
                            color: Color.fromARGB(255, 207, 47, 47),
                            size: 18,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

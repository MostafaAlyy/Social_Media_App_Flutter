import 'package:flutter/material.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/ViewModel/Cupits/chatsCubit/chats_cubit.dart';

import '../../Pages/chats/DetailedChatScr.dart';

Widget chatUser(UserModel user, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailedChatScr(user)),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CircleAvatar(
            maxRadius: 30,
            backgroundImage: NetworkImage(user.image!),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    user.name!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 16),
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

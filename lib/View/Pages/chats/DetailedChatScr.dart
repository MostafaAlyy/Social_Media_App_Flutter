import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Models/UserModel.dart';
import 'package:social_app/View/Components/ChatCompo/receivedMesCompo.dart';
import 'package:social_app/View/Components/ChatCompo/userCompo.dart';
import 'package:social_app/View/Components/ChatCompo/sendedMsgCompo.dart';

import '../../../ViewModel/Cupits/chatsCubit/chats_cubit.dart';

class DetailedChatScr extends StatelessWidget {
  UserModel user;
  DetailedChatScr(this.user, {super.key});
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatsCubit()..getMessages(user.uId, context),
        child: BlocConsumer<ChatsCubit, ChatsState>(listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          var cupit = ChatsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              backgroundColor: Colors.white,
              titleSpacing: 0.0,
              title: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    maxRadius: 20,
                    backgroundImage: NetworkImage(user.image!),
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
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Column(children: [
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: ((context, index) {
                        if (cupit.messages[index].senderId == user.uId) {
                          return receivedMes(context, cupit.messages[index]);
                        }
                        return sendedMsg(context, cupit.messages[index]);
                      }),
                      separatorBuilder: ((context, index) => const SizedBox(
                            height: 15,
                          )),
                      itemCount: cupit.messages.length),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: TextFormField(
                          controller: cupit.messageTypingController,
                          decoration: const InputDecoration(
                            hintText: 'type your message here',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      color: Colors.blue,
                      child: MaterialButton(
                        child: Icon(FontAwesomeIcons.paperPlane),
                        onPressed: () {
                          cupit.sendMessage(
                              text: cupit.messageTypingController.text,
                              dateTime: now.toString(),
                              receiverId: user.uId,
                              context: context);
                        },
                        minWidth: 1,
                      ),
                    )
                  ]),
                ),
              ]),
            ),
          );
        }));
  }
}

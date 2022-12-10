import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/View/Components/ChatCompo/userCompo.dart';

import '../../../ViewModel/Cupits/chatsCubit/chats_cubit.dart';

class ChatScr extends StatelessWidget {
  const ChatScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..getUsers(),
      child: BlocConsumer<ChatsCubit, ChatsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = ChatsCubit.get(context);
          return ConditionalBuilder(
              condition: cupit.users.isNotEmpty,
              builder: ((context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return chatUser(cupit.users[index], context);
                        }),
                        separatorBuilder: ((context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey[400],
                          );
                        }),
                        itemCount: cupit.users.length),
                  )),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
      ),
    );
  }
}

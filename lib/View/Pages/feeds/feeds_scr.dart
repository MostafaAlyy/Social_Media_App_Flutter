// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/Models/UserModel.dart';

import '../../../ViewModel/Cupits/SocialCupit/cupit.dart';
import '../../../ViewModel/Cupits/SocialCupit/states.dart';
import '../../../ViewModel/Cupits/feedsCubit/feeds_cubit.dart';
import '../../Components/FeedsCompo/postCompo.dart';

class FeedsScr extends StatelessWidget {
  const FeedsScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()..getPosts(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cupit = FeedsCubit.get(context);

          return ConditionalBuilder(
              condition: cupit.posts.length > 0 &&
                  SocialCupit.get(context).user != null,
              builder: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.all(8.0),
                        child: const Card(
                          elevation: 15,
                          clipBehavior: Clip.hardEdge,
                          child: Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-vector/connected-concept-illustration_114360-4481.jpg?w=1380&t=st=1662639346~exp=1662639946~hmac=1c6d6b158a5fccac042c4e92e700ca704933da2349b7d09daf3f718073d378cd')),
                        ),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => BuildPost(
                              context, cupit.posts[index].model!, index),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 0),
                          itemCount: cupit.posts.length)
                    ]),
                  ),
              fallback: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  )));
        },
      ),
    );
  }
}

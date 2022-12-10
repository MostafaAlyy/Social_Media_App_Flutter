import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../ViewModel/Cupits/SocialCupit/cupit.dart';
import '../../ViewModel/Cupits/SocialCupit/states.dart';
import '../../ViewModel/Database/local/sharedPreferns.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      String? uId = CashHelper.getData(key: 'uId');
      SocialCupit.get(context).getUserData(uId!);
      return BlocConsumer<SocialCupit, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cupit = SocialCupit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.grey,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey,
                      ))
                ],
                elevation: 0,
                title: Text('${cupit.titles[cupit.currentindex]}',
                    style: TextStyle(color: Colors.black)),
              ),
              body: cupit.screens[cupit.currentindex],
              bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  iconSize: 20,
                  type: BottomNavigationBarType.fixed,
                  enableFeedback: true,
                  currentIndex: cupit.currentindex,
                  onTap: ((value) {
                    cupit.ChangeBottomNAv(value);
                  }),
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                      label: "Feeds",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.commentDots,
                      ),
                      label: "Chats",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.squarePlus,
                      ),
                      label: "Post",
                    ),
                    const BottomNavigationBarItem(
                        icon: Icon(
                          FontAwesomeIcons.users,
                        ),
                        label: "Users"),
                    const BottomNavigationBarItem(
                      icon: Icon(
                        FontAwesomeIcons.userGear,
                      ),
                      label: "Settings",
                    ),
                  ]),
            );
          });
    });
  }
}

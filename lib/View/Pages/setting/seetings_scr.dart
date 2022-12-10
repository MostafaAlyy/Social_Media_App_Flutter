import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../ViewModel/Cupits/SocialCupit/cupit.dart';
import '../../../ViewModel/Cupits/SocialCupit/states.dart';
import 'EditProfileScr.dart';

class SettingScr extends StatelessWidget {
  const SettingScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCupit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cupit = SocialCupit.get(context);
          return SingleChildScrollView(
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
                          child: Image.network(
                            cupit.user!.cover!,
                            cacheHeight: 300,
                            cacheWidth: 600,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            maxRadius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(cupit.user!.image!),
                              maxRadius: 60,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                    child: Column(
                  children: [
                    Text(
                      '${cupit.user!.name!}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Bio ....',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12),
                    )
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 30,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "100",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Posts",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "10K",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Followers",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "543",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Following",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "265",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Photos",
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Add Photos')),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfileScr()),
                              );
                            },
                            child: Icon(FontAwesomeIcons.pen))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

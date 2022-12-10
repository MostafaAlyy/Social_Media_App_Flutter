import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'View/Pages/Home_Scr.dart';
import 'View/Pages/login_scr.dart';
import 'ViewModel/Cupits/SocialCupit/cupit.dart';
import 'ViewModel/Database/local/sharedPreferns.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String? uId = CashHelper.getData(key: 'uId');
  Widget? widget;

  if (uId != null) {
    widget = MyHomePage();
  } else
    widget = LOGIN_SCR();

  return runApp(MyApp(widget, uId));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  final String? uId;
  MyApp(this.widget, this.uId);

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => SocialCupit(),
      child: MaterialApp(
        title: 'SocialApp',
        debugShowCheckedModeBanner: false,
        home: widget,
        theme:
            ThemeData(bottomNavigationBarTheme: BottomNavigationBarThemeData()),
      ),
    );
  }
}

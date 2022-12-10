import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Models/MessageModel.dart';

Widget sendedMsg(BuildContext context, MessageModel message) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Text(
          message.text!,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16),
        ),
      ),
    ),
  );
}

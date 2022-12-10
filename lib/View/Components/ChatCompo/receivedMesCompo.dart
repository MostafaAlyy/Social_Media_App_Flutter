import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Models/MessageModel.dart';

Widget receivedMes(BuildContext context, MessageModel message) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
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

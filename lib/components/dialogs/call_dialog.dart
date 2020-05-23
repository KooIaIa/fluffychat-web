import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/l10n/l10n.dart';
import 'package:fluffychat/utils/jitsi_controller.dart';
import 'package:flutter/material.dart';

import '../avatar.dart';

class CallDialog extends StatelessWidget {
  final Event event;

  const CallDialog(this.event);

  void _answerCallAction(BuildContext context) {
    Navigator.of(context).pop();
    JitsiController.joinCall(
      context,
      event.body,
      event.room.getLocalizedDisplayname(L10n.of(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final senderName = event.sender.calcDisplayname();
    final senderAvatar = event.sender.avatarUrl;
    return AlertDialog(
      title: Text(L10n.of(context).videoCall),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: Avatar(senderAvatar, senderName),
            title: Text(
              senderName,
              style: TextStyle(fontSize: 18),
            ),
            subtitle:
                event.room.isDirectChat ? null : Text(event.room.displayname),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Spacer(),
              FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.phone_missed),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Spacer(),
              FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(Icons.phone),
                onPressed: () => _answerCallAction(context),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:fluffychat/components/matrix.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class JitsiController {
  static void joinCall(
      BuildContext context, String url, String roomName) async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      try {
        final urlParts = url.split('/');
        final room = urlParts.removeLast();
        final serverURL = urlParts.join('/');
        final options = JitsiMeetingOptions()
          ..room = room
          ..serverURL = serverURL
          ..subject = roomName
          ..userDisplayName = Matrix.of(context).client.userID;
        await JitsiMeet.joinMeeting(options);
      } catch (error) {
        debugPrint('error: $error');
        BotToast.showText(text: error.toString());
      }
    } else {
      await launch(url);
    }
  }
}

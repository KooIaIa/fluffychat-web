import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/i18n/i18n.dart';
import 'package:flutter/material.dart';

extension LocalizedRoomDisplayname on Room {
  String getLocalizedDisplayname(BuildContext context) {
    if ((this.name?.isEmpty ?? true) &&
        (this.canonicalAlias?.isEmpty ?? true) &&
        !this.isDirectChat &&
        (this.mHeroes != null && this.mHeroes.isNotEmpty)) {
      return I18n.tr(context).groupWith(this.displayname);
    }
    if ((this.name?.isEmpty ?? true) &&
        (this.canonicalAlias?.isEmpty ?? true) &&
        !this.isDirectChat &&
        (this.mHeroes?.isEmpty ?? true)) {
      return I18n.tr(context).emptyChat;
    }
    return this.displayname;
  }
}

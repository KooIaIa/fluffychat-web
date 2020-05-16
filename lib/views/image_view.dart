import 'package:famedlysdk/famedlysdk.dart';
import 'package:fluffychat/components/image_bubble.dart';
import 'package:fluffychat/components/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';
import '../utils/event_extension.dart';

class ImageView extends StatelessWidget {
  final Event event;

  const ImageView(this.event, {Key key}) : super(key: key);

  void _forwardAction(BuildContext context) async {
    Matrix.of(context).shareContent = event.content;
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.reply),
            onPressed: () => _forwardAction(context),
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => event.openFile(context),
            color: Colors.white,
          ),
        ],
      ),
      body: ZoomableWidget(
        minScale: 0.3,
        maxScale: 2.0,
        // default factor is 1.0, use 0.0 to disable boundary
        panLimit: 0.8,
        child: ImageBubble(event, tapToView: false),
      ),
    );
  }
}
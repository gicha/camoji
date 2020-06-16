import 'dart:async';

import 'package:camoji/models/history.dart';
import 'package:flutter/foundation.dart';
import 'package:roslib/roslib.dart';
import 'package:intl/intl.dart';

enum RosState { disconnect, connect, loading }

class RosProvider with ChangeNotifier {
  Ros ros;
  Topic emotion;
  Topic date;

  List<History> history = List<History>();
  History newItem;

  double summEmotion = 0;

  static final RosProvider _singleton = RosProvider._internal();
  factory RosProvider() => _singleton;
  RosProvider._internal();
  RosState state = RosState.loading;

  Future init() async {
    ros = Ros(url: 'ws://192.168.1.84:9090');
    ros.connect();
    emotion = Topic(
      ros: ros,
      name: 'emotion',
      type: "std_msgs/String",
      reconnectOnClose: true,
      latch: true,
      queueSize: 10,
    );

    date = Topic(
      ros: ros,
      name: 'timer',
      type: "std_msgs/String",
      reconnectOnClose: true,
      latch: true,
      queueSize: 10,
    );
    Future.wait([
      emotion.subscribe(),
      date.subscribe(),
    ]);
    emotion.subscription.listen(
      (item) => updateData(
        emotionString: item["msg"]["data"],
      ),
    );
    date.subscription.listen(
      (item) => updateData(
        dateFromEpoch: double.tryParse(item["msg"]["data"]).floor(),
      ),
    );
  }

  updateData({String emotionString, int dateFromEpoch}) {
    newItem = History(
      formatEmotion(emotionString) ?? newItem?.emotion,
      formatDate(dateFromEpoch) ?? newItem?.time,
    );
    if (newItem?.emotion != null && newItem?.time != null) {
      history.add(newItem);
      print(newItem);
      newItem = null;
    }
    notifyListeners();
  }

  String formatDate(int date) {
    if (date == null) return null;
    DateTime d = DateTime.fromMillisecondsSinceEpoch(
      date * 1000,
      isUtc: true,
    );
    d = d.add(Duration(hours: 3));
    return DateFormat("d MMMM 'в' H:mm").format(d);
  }

  EmotionType formatEmotion(String emotion) {
    EmotionType formatEmotion;
    switch (emotion?.toLowerCase()) {
      case "negative":
        formatEmotion = EmotionType.negative;
        break;
      case "neutral":
        formatEmotion = EmotionType.neutral;
        summEmotion += 0.5;
        break;
      case "positive":
        formatEmotion = EmotionType.positive;
        summEmotion += 1;
        break;
      default:
    }
    return formatEmotion;
  }

  setState(RosState _state) {
    state = _state;
    notifyListeners();
  }
}

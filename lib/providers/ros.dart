import 'package:flutter/foundation.dart';
import 'package:roslib/roslib.dart';

enum RosState { disconnect, connect, loading }

class RosProvider with ChangeNotifier {
  Ros ros;
  Topic emotion;
  Topic probability;
  Topic date;

  static final RosProvider _singleton = RosProvider._internal();
  factory RosProvider() => _singleton;
  RosProvider._internal() {
    init();
  }
  RosState state = RosState.loading;

  init() async {
    ros = Ros(url: 'ws://192.168.1.59:9090');
    ros.connect();

    emotion = Topic(
      ros: ros,
      name: 'emotion',
      type: "std_msgs/String",
      reconnectOnClose: true,
      latch: true,
      queueSize: 10,
    );
    probability = Topic(
      ros: ros,
      name: 'probability',
      type: "std_msgs/Float32",
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
      probability.subscribe(),
      date.subscribe(),
    ]);
  }

  setState(RosState _state) {
    state = _state;
    notifyListeners();
  }
}

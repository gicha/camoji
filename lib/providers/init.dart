import 'package:camoji/main.dart';
import 'package:camoji/api/api.dart';
import 'package:camoji/global/database.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';

enum InitState { loading, boarding, auth, inited }

class InitProvider with ChangeNotifier {
  static final InitProvider _singleton = InitProvider._internal();
  factory InitProvider() => _singleton;
  InitProvider._internal() {
    init();
  }
  InitState state = InitState.loading;

  init() async {
    await DataBase().open();
    var store = stringMapStoreFactory.store("blocs");
    Map<String, dynamic> serialized;
    await Future.wait(<Future>[
      store
          .findFirst(DataBase.db, finder: Finder(filter: Filter.byKey("user")))
          .then((value) => serialized = value?.value),
      Future.delayed(Duration(seconds: 0)) // delay for nice splash
    ]);
    // if (serialized == null) {
    //   Api.init();
    //   setState(InitState.boarding);
    // } else {
    //   Api.init("");
    setState(InitState.inited);
    // }
  }

  setState(InitState _state) {
    state = _state;
    notifyListeners();
  }

  void logout() {
    var store = stringMapStoreFactory.store("blocs");
    store.delete(DataBase.db);
    Api.init();
    setState(InitState.auth);
    globalNavigatorKey.currentState.popUntil((route) => route.isFirst);
  }
}

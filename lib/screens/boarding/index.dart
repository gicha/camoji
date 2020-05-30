import 'package:camoji/components/button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../providers/init.dart';
import '../../theme/theme.dart';
import 'provider.dart';
import 'widgets/animated_list.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> with SingleTickerProviderStateMixin {
  AuthProvider provider;

  @override
  void initState() {
    provider = AuthProvider();
    provider.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    provider.animation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        parent: provider.animationController,
        curve: Curves.easeOut,
      ),
    );
    provider.animation.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<AuthProvider>(
        builder: (context, presenter, child) {
          return CupertinoPageScaffold(
            backgroundColor: ITColors.general,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3 - provider.animation.value,
                      ),
                      Expanded(
                        child: ITAnimatedList(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              '😎  😜  🤔',
                              style: ITStyle.create(fontSize: 50),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            Text(
                              'Camoji',
                              style: ITStyle.headerWhite,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 26,
                            ),
                            Opacity(
                              opacity: .6,
                              child: Text(
                                'Узнайте, что нравится\nвашим клиентам',
                                style: ITStyle.textWhite,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: provider.animation.value,
                            ),
                            Opacity(
                              opacity: provider.animation.value / 100,
                              child: Column(
                                children: [
                                  provider.status == AuthStatus.Loading
                                      ? Container(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: SpinKitPulse(
                                            size: 64,
                                            color: ITColors.white,
                                          ),
                                        )
                                      : Container(
                                          height: 84,
                                          width: 84,
                                          child: FlareActor(
                                            "assets/flare/okay.flr",
                                            alignment: Alignment.topCenter,
                                            fit: BoxFit.cover,
                                            animation: "Untitled",
                                          ),
                                        ),
                                  Opacity(
                                    opacity: (provider.status == AuthStatus.Found) ? 1 : .6,
                                    child: Text(
                                      provider.status == AuthStatus.Found ? 'Подключено' : 'Идет поиск устройства...',
                                      style: ITStyle.captionWhite,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: ITButton(
                              text: provider.status == AuthStatus.Found ? 'Далее' : 'Найти устройство',
                              style: ButtonStyle.White,
                              type: (provider.status == AuthStatus.Found || provider.status == AuthStatus.Start)
                                  ? ButtonType.Active
                                  : ButtonType.Unactive,
                              onTap: () {
                                if (provider.status == AuthStatus.Start) provider.startSearch();
                                if (provider.status == AuthStatus.Found) InitProvider().setState(InitState.inited);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

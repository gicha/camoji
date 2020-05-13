import 'package:camoji/components/button.dart';
import 'package:flutter/cupertino.dart';

import '../../theme/theme.dart';
import 'widgets/animated_list.dart';

class BoardingScreen extends StatefulWidget {
  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height * .3,
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ITButton(
                        text: 'Зарегистрироваться',
                        style: ButtonStyle.White,
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => Container(),
                          ),
                        ),
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
  }
}

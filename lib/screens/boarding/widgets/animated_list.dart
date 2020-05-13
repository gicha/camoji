import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ITAnimatedList extends StatelessWidget {
  const ITAnimatedList({Key key, this.children, this.physics}) : super(key: key);
  final List<Widget> children;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: CustomScrollView(
        physics: physics,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              AnimationConfiguration.toStaggeredList(
                duration: Duration(milliseconds: 700),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 70,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

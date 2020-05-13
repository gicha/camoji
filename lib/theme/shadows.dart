part of './theme.dart';

class ITShadows {
  static BoxShadow picture = BoxShadow(
    blurRadius: 10,
    offset: Offset(0, 7),
    color: Color.fromRGBO(0, 0, 0, 0.2),
  );
  static BoxShadow appbar = BoxShadow(
    blurRadius: 10,
    offset: Offset(0, -7),
    color: Color.fromRGBO(0, 0, 0, 0.15),
  );
  static BoxShadow buttonPressed = BoxShadow(
    blurRadius: 5,
    offset: Offset(0, 5),
    color: ITColors.black.withOpacity(.15),
  );
  static BoxShadow button = BoxShadow(
    blurRadius: 15,
    offset: Offset(0, 15),
    color: ITColors.black.withOpacity(.15),
  );
}

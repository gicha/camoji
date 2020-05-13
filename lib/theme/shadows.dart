part of './theme.dart';

//TODO: place here shadows
class PLShadows {
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
}

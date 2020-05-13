part of './theme.dart';

//TODO: place here text styles
class PLStyle {
  static TextStyle create({
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    Color color,
    TextDecoration decoration,
  }) =>
      GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color ?? PLColors.primary,
        decoration: decoration,
      );

  static TextStyle text = create(fontSize: 14);
  static TextStyle textAccent = create(fontSize: 14, color: PLColors.accent);
}

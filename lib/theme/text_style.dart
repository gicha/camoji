part of './theme.dart';

class ITStyle {
  static TextStyle create({
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    Color color,
    TextDecoration decoration,
    String fontFamily,
  }) =>
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color ?? ITColors.black,
        decoration: decoration,
        fontFamily: fontFamily ?? 'SFProRounded',
      );

  static TextStyle header = create(fontWeight: FontWeight.w500, fontSize: 24);
  static TextStyle headerWhite = create(fontWeight: FontWeight.w500, color: ITColors.white, fontSize: 24);
  static TextStyle text = create(fontSize: 18);
  static TextStyle textMedium = create(fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle textMediumGeneral = create(fontSize: 18, fontWeight: FontWeight.w500, color: ITColors.general);
  static TextStyle textMediumWhite = create(fontSize: 18, fontWeight: FontWeight.w500, color: ITColors.white);
  static TextStyle textGeneral = create(fontSize: 18, color: ITColors.general);
  static TextStyle textGrey = create(fontSize: 18, color: ITColors.grey);
  static TextStyle textWhite = create(fontSize: 18, color: ITColors.white);
  static TextStyle caption = create(fontSize: 14, color: ITColors.grey.withOpacity(.3));
  static TextStyle captionWhite = create(fontSize: 14, color: ITColors.white);
  static TextStyle captionGeneral = create(fontSize: 14, color: ITColors.general);
  static TextStyle inputLabel = create(fontSize: 12, color: ITColors.grey);
  static TextStyle inputHint = create(fontSize: 18, color: ITColors.grey.withOpacity(.4));
  static TextStyle textBlock = create(fontSize: 16, color: ITColors.black);
  static TextStyle textBlockGray = create(fontSize: 16, color: ITColors.grey);
  static TextStyle textAdditional = create(fontSize: 14, color: ITColors.grey, fontWeight: FontWeight.w300);
}

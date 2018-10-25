import 'package:flutter/material.dart';
import 'package:gradient_widgets/src/common.dart';

class GradientText extends Text {
  GradientText(
    String data, {
    this.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    @required this.gradient,
//        this.shaderRect = Rect.fromLTWH(0.0, 0.0, 200.0, 200.0),
    @required this.shaderRect,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : super(
          data,
          key: key,
          style: style.copyWith(
              foreground: Paint()..shader = gradient.createShader(shaderRect)),
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );

  final Key key;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final Gradient gradient;
  final Rect shaderRect;
}

//TextStyle gradientTextStyle(TextStyle textWidget, Gradient gradient,
//    {double width = 200.0, double height = 200.0}) {
//  final Shader textShader =
//  gradient.createShader(Rect.fromLTWH(0.0, 0.0, width, height));
//
//  return textWidget.copyWith(foreground: Paint()
//    ..shader = textShader);
//}

class CircularGradientButton extends StatelessWidget {
  CircularGradientButton(
      {@required this.gradient,
      @required this.child,
      @required this.callback,
      this.increaseHeightBy = 30.0,
      this.increaseWidthBy = 0.0,
      this.elevation = 2.0});

  final Widget child;
  final Gradient gradient;
  final VoidCallback callback;
  final double elevation;
  final double increaseHeightBy;
  final double increaseWidthBy;

  @override
  Widget build(BuildContext context) {
    var a = GradientText(
      '',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: const <Color>[
          Color(0xffff4b1f),
          Color(0xff1fddff),
        ],
      ),
      shaderRect: null,
    );
    return FloatingActionButton(
      elevation: elevation,
      onPressed: callback,
      child: gradientContainer(
          context, gradient, increaseHeightBy, increaseWidthBy, child),
    );
  }
}

class GradientButton extends StatefulWidget {
  GradientButton(
      {@required this.gradient,
      @required this.child,
      @required this.callback,
      this.shape,
      this.shapeRadius,
      this.textStyle,
      this.elevation = 5.0,
      this.isEnabled = true,
      this.disabledGradient,
      this.increaseHeightBy = 0.0,
      this.increaseWidthBy = 0.0});

  final Widget child;
  final Gradient gradient;
  final Gradient disabledGradient;
  final VoidCallback callback;
  final ShapeBorder shape;
  final BorderRadius shapeRadius;
  final TextStyle textStyle;
  final bool isEnabled;
  final double elevation;
  final double increaseHeightBy;
  final double increaseWidthBy;

  @override
  GradientButtonState createState() {
    return new GradientButtonState();
  }
}

class GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    BorderRadius borderRadiusCopy =
        widget.shapeRadius ?? BorderRadius.circular(20.0);
    ShapeBorder shapeCopy =
        widget.shape ?? RoundedRectangleBorder(borderRadius: borderRadiusCopy);
    TextStyle textStyleCopy = widget.textStyle ??
        theme.textTheme.button.copyWith(color: Colors.white);

    Gradient gradient;
    double elevation;
    VoidCallback callback;

    if (widget.isEnabled) {
      gradient = widget.gradient;
      elevation = widget.elevation;
      callback = widget.callback;
    } else {
      elevation = 0.0;
      callback = null;
      gradient = widget.disabledGradient ??
          LinearGradient(
            stops: widget.gradient.stops,
            colors: const <Color>[
              Color(0xffDADADA), // <color name="mystic">#DADADA</color>
              Color(0xffBABEC3), // <color name="french_gray">#BABEC3</color>
            ],
          );
    }

    return RawMaterialButton(
      fillColor: Colors.transparent,
      padding: const EdgeInsets.all(0.0),
      shape: shapeCopy,
      elevation: elevation,
      textStyle: textStyleCopy,
      onPressed: callback,
      child: gradientContainer(context, gradient, widget.increaseHeightBy,
          widget.increaseWidthBy, widget.child),
    );
  }
}
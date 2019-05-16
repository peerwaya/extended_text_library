import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///
///  create by zmtzawqlp on 2019/4/30
///

class SpecialTextSpan extends TextSpan {
  /// actual text
  final String actualText;

  /// the start index in all text
  final int start;

  /// the end index in all text
  int get end => start + actualText.length;

  ///extended_text_field
  ///whether delete all actual text when it try to delete SpecialTextSpan(like a image span)
  final bool deleteAll;

  ///extended_text_field
  ///whether caret can move into special text for SpecialTextSpan(like a image span or @xxxx)
  final bool caretIn;

  SpecialTextSpan({
    TextStyle style,
    @required String text,
    @required String actualText,
    @required this.start,
    this.deleteAll: false,
    this.caretIn: false,
    GestureRecognizer recognizer,
  })  : assert(text != null),
        actualText = actualText ?? text,
        assert(start != null),
        super(
          style: style,
          text: text,
          recognizer: recognizer,
        );

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final SpecialTextSpan typedOther = other;
    return typedOther.text == text &&
        typedOther.style == style &&
        typedOther.actualText == actualText &&
        typedOther.start == start &&
        typedOther.deleteAll == deleteAll;
  }

  @override
  int get hashCode => hashValues(style, text, actualText, start, deleteAll);

  @override
  RenderComparison compareTo(TextSpan other) {
    if (other is SpecialTextSpan) {
      if (other.start != start) {
        return RenderComparison.layout;
      }

      if (other.actualText != actualText ||
          other.text != text ||
          other.style != style) {
        return RenderComparison.paint;
      }
    }

    // TODO: implement compareTo
    return super.compareTo(other);
  }
}

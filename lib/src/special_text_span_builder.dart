import 'package:extended_text_library/src/extended_text_typedef.dart';
import 'package:flutter/material.dart';

abstract class SpecialTextSpanBuilder {
  //build text span to specialText
  TextSpan build(BuildContext context, String data,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap}) {
    if (data == null || data == "") return null;
    List<InlineSpan> inlineList = new List<InlineSpan>();
    if (data.length > 0) {
      SpecialText specialText;
      StringBuffer textStack = StringBuffer();
      //String textStack = "";
      //String text
      for (int i = 0; i < data.length; i++) {
        String char = data[i];
        textStack.write(char);
        if (specialText != null) {
          if (!specialText.isEnd(textStack.toString())) {
            specialText.appendContent(char);
          } else {
            inlineList.add(specialText.finishText());
            specialText = null;
            textStack.clear();
          }
        } else {
          String text = textStack.toString();
          specialText = createSpecialText(context, text,
              textStyle: textStyle, onTap: onTap, index: i);
          if (specialText != null) {
            if (textStack.length - specialText.startFlag.length >= 0) {
              text = text.substring(
                  0, textStack.length - specialText.startFlag.length);
              if (textStack.length > 0) {
                inlineList.add(TextSpan(text: text, style: textStyle));
              }
            }
            textStack.clear();
          }
        }
      }

      if (specialText != null) {
        inlineList.add(TextSpan(
            text: specialText.startFlag + specialText.getContent(),
            style: textStyle));
      } else if (textStack.length > 0) {
        inlineList.add(TextSpan(text: textStack.toString(), style: textStyle));
      }
    } else {
      inlineList.add(TextSpan(text: data, style: textStyle));
    }

    return TextSpan(children: inlineList, style: textStyle);
  }

  //build SpecialText base on startflag
  SpecialText createSpecialText(BuildContext context, String flag,
      {TextStyle textStyle, SpecialTextGestureTapCallback onTap, int index});

  /// start with SpecialText
  bool isStart(String value, String startFlag) {
    return value.endsWith(startFlag);
  }
}

abstract class SpecialText {
  final StringBuffer _contetnt;

  ///start flag of SpecialText
  final String startFlag;

  ///end flag of SpecialText
  final String endFlag;

  ///TextStyle of SpecialText
  final TextStyle textStyle;

  ///tap call back of SpecialText
  final SpecialTextGestureTapCallback onTap;

  SpecialText(this.startFlag, this.endFlag, this.textStyle, {this.onTap})
      : _contetnt = StringBuffer();

  ///finish SpecialText
  InlineSpan finishText();

  ///is end of SpecialText
  bool isEnd(String value) {
    return value.endsWith(endFlag);
  }

  ///append text of SpecialText
  void appendContent(String value) {
    _contetnt.write(value);
  }

  ///get content of SpecialText
  String getContent() {
    return _contetnt.toString();
  }

  @override
  String toString() {
    // TODO: implement toString
    return startFlag + getContent() + endFlag;
  }
}

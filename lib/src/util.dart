import 'dart:convert';

import 'package:charcode/charcode.dart';

String escapeHtml(String html) =>
    const HtmlEscape(HtmlEscapeMode.ELEMENT).convert(html);

String escapeAttribute(String value) {
  var result = new StringBuffer();
  var codeUnits = value.codeUnits;
  var ch;
  for (int i=0; i<codeUnits.length; i++) {
    ch = codeUnits[i];
    if (ch == $backslash) {
      i++;
      if (i == codeUnits.length) {
        result.writeCharCode(ch);
        break;
      }
      ch = codeUnits[i];
      switch (ch) {
        case $quote:
          result.write('&quot;');
          break;
        case $exclamation:
        case $hash:
        case $dollar:
        case $percent:
        case $ampersand:
        case $apostrophe:
        case $lparen:
        case $rparen:
        case $asterisk:
        case $plus:
        case $comma:
        case $dash:
        case $dot:
        case $slash:
        case $colon:
        case $semicolon:
        case $lt:
        case $equal:
        case $gt:
        case $question:
        case $at:
        case $lbracket:
        case $backslash:
        case $rbracket:
        case $caret:
        case $underscore:
        case $backquote:
        case $lbrace:
        case $bar:
        case $rbrace:
        case $tilde:
          result.writeCharCode(ch);
          break;
        default:
          result.write('%5C');
          result.writeCharCode(ch);
      }
    } else  if (ch == $quote) {
      result.write('%22');
    } else {
      result.writeCharCode(ch);
    }
  }
  return result.toString();
}

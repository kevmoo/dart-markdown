import '../ast.dart';
import '../block_parser.dart';
import '../patterns.dart';
import 'block_html_syntax.dart';

class BlockTagBlockHtmlSyntax extends BlockHtmlSyntax {
  const BlockTagBlockHtmlSyntax();

  static final _pattern = RegExp(
    '^ {0,3}</?(?:address|article|aside|base|basefont|blockquote|body|'
    'caption|center|col|colgroup|dd|details|dialog|dir|div|dl|dt|fieldset|'
    'figcaption|figure|footer|form|frame|frameset|h1|head|header|hr|html|'
    'iframe|legend|li|link|main|menu|menuitem|meta|nav|noframes|ol|optgroup|'
    'option|p|param|section|source|summary|table|tbody|td|tfoot|th|thead|'
    'title|tr|track|ul)'
    r'(?:\s|>|/>|$)',
  );

  /// The [_pattern] regular expression above is very expensive, even on
  /// paragraphs of Markdown with no HTML. This regular expression can be used
  /// first as a basic check that the input might possibly be an HTML block
  /// tag, which occur very rarely in typical Markdown.
  static final _openBracketPattern = RegExp('^ {0,3}<');

  @override
  RegExp get pattern => _pattern;

  @override
  bool canParse(BlockParser parser) {
    if (!_openBracketPattern.hasMatch(parser.current)) return false;
    return super.canParse(parser);
  }

  @override
  Node parse(BlockParser parser) {
    final childLines = <String>[];

    // Eat until we hit a blank line.
    while (!parser.isDone && !parser.matches(emptyPattern)) {
      childLines.add(parser.current);
      parser.advance();
    }

    return Text(childLines.join('\n').trimRight());
  }
}

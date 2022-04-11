import '../block_parser.dart';
import 'block_syntax.dart';

/// Parses inline HTML at the block level. This differs from other Markdown
/// implementations in several ways:
///
/// 1.  This one is way way WAY simpler.
/// 2.  Essentially no HTML parsing or validation is done. We're a Markdown
///     parser, not an HTML parser!
abstract class BlockHtmlSyntax extends BlockSyntax {
  const BlockHtmlSyntax();

  @override
  bool canEndBlock(BlockParser parser) => true;
}

// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../ast.dart';
import '../block_parser.dart';

abstract class BlockSyntax {
  const BlockSyntax();

  /// Gets the regex used to identify the beginning of this block, if any.
  RegExp get pattern;

  RegExp? get patternWithHelper => null;

  bool canEndBlock(BlockParser parser) => true;

  bool canParse(BlockParser parser) {
    return parser.canMatch(parser.current, this);
  }

  Node? parse(BlockParser parser);

  /// Gets whether or not [parser]'s current line should end the previous block.
  static bool isAtBlockEnd(BlockParser parser) {
    if (parser.isDone) return true;
    return parser.blockSyntaxes
        .any((s) => s.canParse(parser) && s.canEndBlock(parser));
  }

  /// Generates a valid HTML anchor from the inner text of [element].
  static String generateAnchorHash(Element element) => element.textContent
      .toLowerCase()
      .trim()
      .replaceAll(RegExp('[^a-z0-9 _-]'), '')
      .replaceAll(RegExp(r'\s'), '-');
}
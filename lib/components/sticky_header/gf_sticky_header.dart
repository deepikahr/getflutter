import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class GFStickyHeader extends MultiChildRenderObjectWidget {
  GFStickyHeader({
    Key key,
    @required this.header,
    @required this.content,
  }) : super(
    key: key,
    children: [content, header],
  );

  ///
  final Widget header;

  ///
  final Widget content;

  @override
  RenderGFStickyHeader createRenderObject(BuildContext context) {
    final scrollable = Scrollable.of(context);
    assert(scrollable != null);
    return RenderGFStickyHeader(
      scrollable: scrollable,
      enableHeaderOverlap: false,
    );
  }
}


class RenderGFStickyHeader extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData> {

  RenderGFStickyHeader({
    @required ScrollableState scrollable,
    bool enableHeaderOverlap = false,
    RenderBox header,
    RenderBox content,
  })  : assert(scrollable != null),
        _scrollable = scrollable,
        _enableHeaderOverlap = enableHeaderOverlap {
    if (content != null) {
      add(content);
    }
    if (header != null) {
      add(header);
    }
  }

  final ScrollableState _scrollable;
  final bool _enableHeaderOverlap;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  RenderBox get _headerTile => lastChild;

  RenderBox get _contentBody => firstChild;

  @override
  void performLayout() {
    assert(childCount == 2);
    _headerTile.layout(constraints.loosen(), parentUsesSize: true);
    _contentBody.layout(constraints.loosen(), parentUsesSize: true);

    final headerTileHeight = _headerTile.size.height;
    final contentBodyHeight = _contentBody.size.height;

    final height = max(constraints.minHeight, _enableHeaderOverlap ? contentBodyHeight : headerTileHeight + contentBodyHeight);
    final width = max(constraints.minWidth, contentBodyHeight);

    size =  Size(constraints.constrainWidth(width), constraints.constrainHeight(height));

    final scrollableContent = _scrollable.context.findRenderObject();
    final double headerTileOffset = scrollableContent.attached ? localToGlobal(Offset.zero, ancestor: scrollableContent).dy : Offset.zero;

    final MultiChildLayoutParentData contentBodyParentData = _contentBody.parentData;
    contentBodyParentData.offset = Offset(0, _enableHeaderOverlap ? 0.0 : headerTileHeight);

    final MultiChildLayoutParentData headerTileParentData = _headerTile.parentData;
    headerTileParentData.offset =  Offset(0, max(0, min(-headerTileOffset, height - headerTileHeight)));

  }

  @override
  void setupParentData(RenderObject child) {
    super.setupParentData(child);
    child.parentData = MultiChildLayoutParentData();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
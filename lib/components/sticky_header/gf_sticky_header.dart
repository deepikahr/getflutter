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

  final Widget header;

  final Widget content;

  @override
  RenderGFStickyHeader createRenderObject(BuildContext context) {
    final scrollable = Scrollable.of(context);
    assert(scrollable != null);
    return RenderGFStickyHeader(
      scrollable: scrollable,
    );
  }

  // @override
  // void updateRenderObject(BuildContext context, RenderGFStickyHeader renderObject) {
  //   renderObject
  //     ..scrollable = Scrollable.of(context)
  //     ..callback = callback
  //     ..overlapHeaders = overlapHeaders;
  // }
}


class RenderGFStickyHeader extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData> {

  RenderGFStickyHeader({
    @required ScrollableState scrollable,
    // RenderGFStickyHeaderCallback callback,
    bool overlapHeaders = false,
    RenderBox header,
    RenderBox content,
  })  : assert(scrollable != null),
        _scrollable = scrollable,
        // _callback = callback,
        _overlapHeaders = overlapHeaders {
    if (content != null) {
      add(content);
    }
    if (header != null) {
      add(header);
    }
  }

  ScrollableState _scrollable;
  bool _overlapHeaders;


  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position?.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position?.removeListener(markNeedsLayout);
    super.detach();
  }

  // short-hand to access the child RenderObjects
  RenderBox get _headerTile => lastChild;

  RenderBox get _contentBody => firstChild;

  @override
  void performLayout() {
    assert(childCount == 2);
    final itemConstraints = constraints.loosen();
    _headerTile.layout(itemConstraints, parentUsesSize: true);
    _contentBody.layout(itemConstraints, parentUsesSize: true);

    final headerTileHeight = _headerTile.size.height;
    final contentBodyHeight = _contentBody.size.height;

    final height = max(constraints.minHeight,
        _overlapHeaders ? contentBodyHeight : headerTileHeight + contentBodyHeight);
    final width = max(constraints.minWidth, _contentBody.size.width);

    size =  Size(width, height);
    assert(size.width == constraints.constrainWidth(width));
    assert(size.height == constraints.constrainHeight(height));
    assert(size.isFinite);

    final MultiChildLayoutParentData contentBodyParentData = _contentBody.parentData;
    contentBodyParentData.offset = Offset(0, _overlapHeaders ? 0.0 : headerTileHeight);

    final double headerTileOffset = getHeaderTileOffset();

    final double maxOffset = height - headerTileHeight;
    final MultiChildLayoutParentData headerTileParentData = _headerTile.parentData;
    headerTileParentData.offset =  Offset(0, max(0, min(-headerTileOffset, maxOffset)));

  }

  double getHeaderTileOffset() {
    final scrollBox = _scrollable.context.findRenderObject();
    if (scrollBox?.attached ?? false) {
      try {
        return localToGlobal(Offset.zero, ancestor: scrollBox).dy;
      } catch (e) {
      }
    }
    return 0.0;
  }

  @override
  void setupParentData(RenderObject child) {
    super.setupParentData(child);
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
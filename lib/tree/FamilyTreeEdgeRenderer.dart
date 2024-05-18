part of graphview;

class FamilyTreeEdgeRenderer extends EdgeRenderer {
  final FamilyTreeBuchheimWalkerConfiguration configuration;

  const FamilyTreeEdgeRenderer(this.configuration);

  @override
  void render(Canvas canvas, Graph graph, Paint paint) {
    final levelSeparationHalf = configuration.levelSeparation / 2;
    final linePath = Path();
    graph.nodes.forEach((node) {
      final children = graph.successorsOf(node);
      children.forEach((child) {
        final edge = graph.getEdgeBetween(node, child);
        final hasSpouse = (child as FamilyNode).hasSpouse;
        final edgePaint = (edge?.paint ?? paint)..style = PaintingStyle.stroke;
        linePath.reset();
        if (hasSpouse) {
          // position at the left-middle-top of the child
          linePath.moveTo(
              (child.x + (child.width - configuration.spouseSeparation) / 4),
              child.y);
          // draws a line from the child's middle-top halfway up to its parent
          linePath.lineTo(
              (child.x + (child.width - configuration.spouseSeparation) / 4),
              child.y - levelSeparationHalf);
          // draws a line from the previous point to the middle of the parents width
          linePath.lineTo(
              node.x + node.width / 2, child.y - levelSeparationHalf);

          // draws a line up from the previous point to the parents middle-center
          linePath.lineTo(node.x + node.width / 2, node.y + node.height / 2);
        } else {
          // position at the middle-top of the child
          linePath.moveTo((child.x + child.width / 2), child.y);
          // draws a line from the child's middle-top halfway up to its parent
          linePath.lineTo(
              child.x + child.width / 2, child.y - levelSeparationHalf);
          // draws a line from the previous point to the middle of the parents width
          linePath.lineTo(
              node.x + node.width / 2, child.y - levelSeparationHalf);

          // draws a line up from the previous point to the parents middle-center
          linePath.lineTo(node.x + node.width / 2, node.y + node.height / 2);
        }
        canvas.drawPath(linePath, edgePaint);
      });
    });
  }
}

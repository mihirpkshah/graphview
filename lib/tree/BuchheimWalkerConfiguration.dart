part of graphview;

class BuchheimWalkerConfiguration {
  static const ORIENTATION_TOP_BOTTOM = 1;
  static const ORIENTATION_BOTTOM_TOP = 2;
  static const ORIENTATION_LEFT_RIGHT = 3;
  static const ORIENTATION_RIGHT_LEFT = 4;
  static const DEFAULT_SIBLING_SEPARATION = 100;
  static const DEFAULT_SUBTREE_SEPARATION = 100;
  static const DEFAULT_LEVEL_SEPARATION = 100;
  static const DEFAULT_ORIENTATION = 1;

  final int siblingSeparation; // = DEFAULT_SIBLING_SEPARATION;
  final int levelSeparation; // = DEFAULT_LEVEL_SEPARATION;
  final int subtreeSeparation; // = DEFAULT_SUBTREE_SEPARATION;
  final int orientation; // = DEFAULT_ORIENTATION;

  BuchheimWalkerConfiguration(
      {this.siblingSeparation = DEFAULT_SIBLING_SEPARATION,
      this.levelSeparation = DEFAULT_LEVEL_SEPARATION,
      this.subtreeSeparation = DEFAULT_SUBTREE_SEPARATION,
      this.orientation = DEFAULT_ORIENTATION});
}

class FamilyTreeBuchheimWalkerConfiguration
    extends BuchheimWalkerConfiguration {
  static const DEFAULT_SPOUSE_SEPARATION = 100;
  final int spouseSeparation; // = DEFAULT_SPOUSE_SEPARATION;

  FamilyTreeBuchheimWalkerConfiguration(
      {int siblingSeparation =
          BuchheimWalkerConfiguration.DEFAULT_SIBLING_SEPARATION,
      int levelSeparation =
          BuchheimWalkerConfiguration.DEFAULT_LEVEL_SEPARATION,
      int subtreeSeparation =
          BuchheimWalkerConfiguration.DEFAULT_SUBTREE_SEPARATION,
      this.spouseSeparation = DEFAULT_SPOUSE_SEPARATION})
      : super(
            siblingSeparation: siblingSeparation,
            levelSeparation: levelSeparation,
            subtreeSeparation: subtreeSeparation,
            orientation: BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
}

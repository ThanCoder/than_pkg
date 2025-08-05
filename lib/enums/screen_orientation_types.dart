enum ScreenOrientationTypes {
  portrait,
  landscape;

  static ScreenOrientationTypes getType(String name) {
    if (landscape.name == name) {
      return landscape;
    }
    return portrait;
  }

  static String getName(ScreenOrientationTypes type) {
    if (landscape.name == type.name) {
      return landscape.name;
    }
    return portrait.name;
  }
}



enum ScreenOrientationTypes {
  portrait,
  landscape,
  portraitReverse,
  landscapeReverse,
  autoRotate,
  fourWaySensor;

  static ScreenOrientationTypes getType(String name) {
    final index = ScreenOrientationTypes.values.indexWhere(
      (e) => e.name == name,
    );
    if (index != -1) {
      return ScreenOrientationTypes.values[index];
    }
    return portrait;
  }
}

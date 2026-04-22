enum Flavor { dev, stage, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Secure Stream Dev';
      case Flavor.stage:
        return 'Secure Stream Stage';
      case Flavor.prod:
        return 'Secure Stream';
    }
  }
}

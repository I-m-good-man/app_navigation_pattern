abstract class AppPath {}

abstract class MainPath extends AppPath {}

class LaunchPath extends MainPath {}

class HomePath extends LaunchPath {}

class UndefinedPath extends LaunchPath {}

class UnexpectedAppPathException implements Exception {
  @override
  String toString() {
    return 'Unexpected AppPath: "${undefinedAppPath.runtimeType}"';
  }

  final AppPath undefinedAppPath;

  UnexpectedAppPathException({required this.undefinedAppPath});
}
import 'package:flutter_test/flutter_test.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_pkg/than_pkg_platform_interface.dart';
import 'package:than_pkg/than_pkg_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockThanPkgPlatform
    with MockPlatformInterfaceMixin
    implements ThanPkgPlatform {
  // @override
  // Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ThanPkgPlatform initialPlatform = ThanPkgPlatform.instance;

  test('$MethodChannelThanPkg is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelThanPkg>());
  });

  test('getPlatformVersion', () async {
    ThanPkg thanPkgPlugin = ThanPkg();
    MockThanPkgPlatform fakePlatform = MockThanPkgPlatform();
    ThanPkgPlatform.instance = fakePlatform;

    expect(await thanPkgPlugin.getPlatformVersion(), '42');
  });
}

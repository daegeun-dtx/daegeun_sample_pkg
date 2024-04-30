import 'package:flutter_test/flutter_test.dart';
import 'package:daegeun_sample_pkg/daegeun_sample_pkg.dart';
import 'package:daegeun_sample_pkg/daegeun_sample_pkg_platform_interface.dart';
import 'package:daegeun_sample_pkg/daegeun_sample_pkg_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDaegeunSamplePkgPlatform
    with MockPlatformInterfaceMixin
    implements DaegeunSamplePkgPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value("Android 14");

  @override
  Future<List<String>?> getAvailableTimeZones() => Future.value(["Asia/Seoul"]);

  @override
  Future<String?> getLocalTimeZone() => Future.value("Asia/Seoul");
}

void main() {
  final DaegeunSamplePkgPlatform initialPlatform = DaegeunSamplePkgPlatform.instance;

  test('$MethodChannelDaegeunSamplePkg is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDaegeunSamplePkg>());
  });

  test('getPlatformVersion', () async {
    DaegeunSamplePkg daegeunSamplePkgPlugin = DaegeunSamplePkg();
    MockDaegeunSamplePkgPlatform fakePlatform = MockDaegeunSamplePkgPlatform();
    DaegeunSamplePkgPlatform.instance = fakePlatform;

    expect(await daegeunSamplePkgPlugin.getPlatformVersion(), "Android 14");
  });

  test("getLocalTimeZone", ()async{
    DaegeunSamplePkg daegeunSamplePkgPlugin = DaegeunSamplePkg();
    MockDaegeunSamplePkgPlatform fakePlatform = MockDaegeunSamplePkgPlatform();
    DaegeunSamplePkgPlatform.instance = fakePlatform;

    expect(await daegeunSamplePkgPlugin.getLocalTimeZone(), "Asia/Seoul");
  });

  test("getAvailableTimeZones", ()async{
    DaegeunSamplePkg daegeunSamplePkgPlugin = DaegeunSamplePkg();
    MockDaegeunSamplePkgPlatform fakePlatform = MockDaegeunSamplePkgPlatform();
    DaegeunSamplePkgPlatform.instance = fakePlatform;

    expect(await daegeunSamplePkgPlugin.getAvailableTimeZones(), ["Asia/Seoul"]);
  });
}

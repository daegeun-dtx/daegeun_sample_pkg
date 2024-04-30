import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'daegeun_sample_pkg_method_channel.dart';

/// PlatformInterface를 확장한 플러그인의 플랫폼 구현체의 정의입니다.
abstract class DaegeunSamplePkgPlatform extends PlatformInterface {
  /// 생성자
  DaegeunSamplePkgPlatform() : super(token: _token);

  static final Object _token = Object();

  static DaegeunSamplePkgPlatform _instance = MethodChannelDaegeunSamplePkg();

  /// [DaegeunSamplePkgPlatform]의 인스턴스입니다.
  ///
  /// 기본값은 [MethodChannelDaegeunSamplePkg]입니다.
  static DaegeunSamplePkgPlatform get instance => _instance;

  /// 특정 플랫폼을 위한 구현체가 자신을 등록할 때 이를 재설정해야 합니다.
  ///
  /// 다만 package_info_plus 같이 일부 플러그인에서는 설정하지 않은 경우도 존재합니다.
  static set instance(DaegeunSamplePkgPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 플랫폼 버전을 가져오는 메소드입니다. 추상 클래스에서는 구현하지 않습니다.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 로컬 타임존을 가져오는 메서드입니다. 추상 클래스에서는 구현하지 않습니다.
  Future<String?> getLocalTimeZone() {
    throw UnimplementedError('getLocalTimeZone() has not been implemented.');
  }

  /// 사용 가능한 타임존 목록을 가져오는 메서드입니다. 추상 클래스에서는 구현하지 않습니다.
  Future<List<String>?> getAvailableTimeZones() {
    throw UnimplementedError('getAvailableTimeZones() has not been implemented.');
  }
}


import 'daegeun_sample_pkg_platform_interface.dart';

/// 플랫폼과 상호작용하는 예시 메서드입니다.
///
/// 이 클래스가 이 패키지를 사용하는 앱에 노출되는 API입니다.
class DaegeunSamplePkg {
  /// 플랫폼 버전을 검색합니다.
  ///
  /// 이 메서드는 플랫폼 인터페이스와 통신하여 플랫폼의 버전을 가져옵니다.
  /// "Android 버전번호" 혹은 "iOS 버전번호" 형태의 [String] 형태로 반환합니다.
  Future<String?> getPlatformVersion() {
    return DaegeunSamplePkgPlatform.instance.getPlatformVersion();
  }

  /// 로컬 시간대를 검색합니다.
  ///
  /// 이 메서드는 플랫폼 인터페이스와 통신하여 로컬 시간대를 가져옵니다.
  Future<String?> getLocalTimeZone() async{
    return DaegeunSamplePkgPlatform.instance.getLocalTimeZone();
  }

  /// 사용 가능한 시간대 목록을 검색합니다.
  ///
  /// 이 메서드는 플랫폼 인터페이스와 통신하여 사용 가능한 시간대 목록을 가져옵니다.
  Future<List<String>?> getAvailableTimeZones() async{
    return DaegeunSamplePkgPlatform.instance.getAvailableTimeZones();
  }
}

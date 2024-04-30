import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'daegeun_sample_pkg_platform_interface.dart';

/// [DaegeunSamplePkgPlatform]의 메소드 채널 구현체입니다.
class MethodChannelDaegeunSamplePkg extends DaegeunSamplePkgPlatform {
  /// 네이티브 플랫폼과 통신하기 위한 메소드 채널 인스턴스
  @visibleForTesting
  final methodChannel = const MethodChannel('daegeun_sample_pkg');

  /// 플랫폼 버전을 가져오는 메소드입니다. 각 플랫폼에서 구현한 결과를 가져옵니다.
  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// 로컬 타임존을 가져오는 메소드입니다. 각 플랫폼에서 구현한 결과를 가져옵니다.
  @override
  Future<String?> getLocalTimeZone() async{
    final String? timeZone = await methodChannel.invokeMethod<String>("getLocalTimeZone");
    return timeZone;
  }

  /// 사용 가능한 타임존 목록을 가져오는 메소드입니다. 각 플랫폼에서 구현한 결과를 가져옵니다.
  @override
  Future<List<String>?> getAvailableTimeZones() async{
    final List<String>? timeZones = await methodChannel.invokeListMethod<String>('getAvailableTimeZones');
    return timeZones;
  }
}

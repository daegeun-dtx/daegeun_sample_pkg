import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daegeun_sample_pkg/daegeun_sample_pkg_method_channel.dart';

void main() {
  // 테스트 위젯의 Flutter 바인딩을 초기화
  TestWidgetsFlutterBinding.ensureInitialized();

  // MethodChannelDaegeunSamplePkg 클래스 생성
  MethodChannelDaegeunSamplePkg platform = MethodChannelDaegeunSamplePkg();
  // MethodChannel 클래스의 인스턴스를 생성
  const MethodChannel channel = MethodChannel('daegeun_sample_pkg');

  /// MethodChannel 클래스의 목업 메소드 호출 핸들러
  Future<Object?> mockMethodCallHandler(MethodCall methodCall) async {
    switch(methodCall.method){
      case "getAvailableTimeZones":
        return ["Asia/Seoul"];
      case "getLocalTimeZone":
        return "Asia/Seoul";
      case "getPlatformVersion":
        return "Android 14";
      default:
      // 정의되지 않은 메서드 호출에 대한 예외를 발생시킵니다.
        throw UnimplementedError();
    }
  }

  setUp(() {
    // 목업 메서드 호출 핸들러를 설정
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      mockMethodCallHandler,
    );
  });

  tearDown(() {
    // 목업 메서드 호출 핸들러를 제거
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), 'Android 14');
  });

  test('getLocalTimeZone', () async {
    expect(await platform.getLocalTimeZone(), 'Asia/Seoul');
  });

  test('getAvailableTimeZones', () async {
    expect(await platform.getAvailableTimeZones(), ["Asia/Seoul"]);
  });
}
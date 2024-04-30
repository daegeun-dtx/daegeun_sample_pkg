import Flutter
import UIKit

// FlutterPlugin을 구현한 iOS 플러그인 클래스
public class DaegeunSamplePkgPlugin: NSObject, FlutterPlugin {

  // Flutter 플러그인을 등록하는 메소드입니다.
  // FlutterMethodChannel을 생성하고, 이를 통해 Flutter와 네이티브 코드 간의 통신이 가능하게 합니다.
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "daegeun_sample_pkg", binaryMessenger: registrar.messenger())
    let instance = DaegeunSamplePkgPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  // Flutter에서 호출한 메소드를 처리하는 메소드입니다.
  // 각 메소드 이름에 따라 다른 동작을 수행하고, 결과를 Flutter에 반환합니다.
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      // 현재 플랫폼의 버전을 반환합니다.
      result("iOS " + UIDevice.current.systemVersion)
    case "getLocalTimeZone":
      // 현재 시스템의 타임존을 반환합니다.
      let tzName = TimeZone.current.identifier
      result(tzName)
    case "getAvailableTimeZones":
      // 사용 가능한 모든 타임존을 반환합니다.
      result(TimeZone.knownTimeZoneIdentifiers)
    default:
      // Flutter에서 호출한 메소드가 이 플러그인에서 구현되지 않았을 경우, 에러를 반환합니다.
      result(FlutterError(code: "FlutterMethodNotImplemented",
                          message: "No method found for \(call.method)",
                          details: nil))
    }
  }
}
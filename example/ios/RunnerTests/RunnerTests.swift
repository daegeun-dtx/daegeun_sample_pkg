import Flutter
import UIKit
import XCTest

@testable import daegeun_sample_pkg

// DaegeunSamplePkgPlugin에 대한 테스트를 정의합니다.
class DaegeunSamplePkgPluginTests: XCTestCase {
  var plugin: DaegeunSamplePkgPlugin!
  var call: FlutterMethodCall!

  // 각 테스트 전에 실행되는 메소드입니다. 테스트에 필요한 초기 설정을 수행합니다.
  override func setUp() {
    super.setUp()
    plugin = DaegeunSamplePkgPlugin()
  }

  // getPlatformVersion 메소드에 대한 테스트입니다.
  func testGetPlatformVersion() {
    call = FlutterMethodCall(methodName: "getPlatformVersion", arguments: [])
    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      // 플랫폼 버전을 반환하는지 확인합니다.
      XCTAssertEqual(result as! String, "iOS " + UIDevice.current.systemVersion)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  // getLocalTimeZone 메소드에 대한 테스트입니다.
  func testGetLocalTimeZone() {
    call = FlutterMethodCall(methodName: "getLocalTimeZone", arguments: [])
    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      // 현재 시스템의 타임존을 반환하는지 확인합니다.
      XCTAssertEqual(result as! String, TimeZone.current.identifier)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  // getAvailableTimeZones 메소드에 대한 테스트입니다.
  func testGetAvailableTimeZones() {
    call = FlutterMethodCall(methodName: "getAvailableTimeZones", arguments: [])
    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      // 사용 가능한 모든 타임존을 반환하는지 확인합니다.
      XCTAssertEqual(result as! [String], TimeZone.knownTimeZoneIdentifiers)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  // 구현되지 않은 메소드에 대한 테스트입니다.
  func testMethodNotImplemented() {
    call = FlutterMethodCall(methodName: "nonExistentMethod", arguments: [])
    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      // FlutterError가 반환되는지 확인합니다.
      XCTAssertTrue(result is FlutterError)
      let error = result as! FlutterError
      // 에러 코드가 "FlutterMethodNotImplemented"인지 확인합니다.
      XCTAssertEqual(error.code, "FlutterMethodNotImplemented")
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }
}
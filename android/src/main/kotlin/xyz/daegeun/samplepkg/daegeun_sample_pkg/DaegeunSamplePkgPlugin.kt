package xyz.daegeun.samplepkg.daegeun_sample_pkg

import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.time.ZoneId
import java.util.*
import kotlin.collections.ArrayList

/**
 * DaegeunSamplePkgPlugin 클래스는 FlutterPlugin과 MethodCallHandler 인터페이스를 구현합니다. 이 클래스는 플러그인이 엔진에 연결되거나
 * 연결이 해제될 때의 동작을 정의하고, 플러그인이 받는 메소드 호출을 처리합니다.
 */
class DaegeunSamplePkgPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    /** 플러그인이 엔진에 연결될 때 호출됩니다. 이 메소드에서는 MethodChannel을 설정합니다. */
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        setupMethodChannel(flutterPluginBinding)
    }

    /**
     * 플러그인이 받는 메소드 호출을 처리합니다. 현재 "getPlatformVersion", "getLocalTimeZone", "getAvailableTimeZones"
     * 메소드를 처리하고 있습니다.
     */
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
            "getLocalTimeZone" -> result.success(getLocalTimezone())
            "getAvailableTimeZones" -> result.success(getAvailableTimezones())
            else -> result.notImplemented()
        }
    }

    /**
     * 플러그인이 엔진에서 연결 해제될 때 호출됩니다. 이 메소드에서는 MethodChannel의 메소드 호출 핸들러를 null로 설정하여 메소드 호출을 더 이상 받지 않도록
     * 합니다.
     */
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /** 현재 시스템의 로컬 타임존을 반환합니다. */
    private fun getLocalTimezone(): String {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ZoneId.systemDefault().id
        } else {
            TimeZone.getDefault().id
        }
    }

    /** 사용 가능한 모든 타임존을 반환합니다. */
    private fun getAvailableTimezones(): List<String> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ZoneId.getAvailableZoneIds().toCollection(ArrayList())
        } else {
            TimeZone.getAvailableIDs().toCollection(ArrayList())
        }
    }

    /** MethodChannel을 설정합니다. 이 메소드에서는 MethodChannel의 인스턴스를 생성하고, 메소드 호출 핸들러를 설정합니다. */
    private fun setupMethodChannel(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "daegeun_sample_pkg")
        channel.setMethodCallHandler(this)
    }
}

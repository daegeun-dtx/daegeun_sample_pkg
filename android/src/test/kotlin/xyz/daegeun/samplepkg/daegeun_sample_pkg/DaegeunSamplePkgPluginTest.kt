package xyz.daegeun.samplepkg.daegeun_sample_pkg

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.time.ZoneId
import java.util.*
import kotlin.collections.ArrayList
import kotlin.test.BeforeTest
import kotlin.test.Test
import org.mockito.Mockito

/** DaegeunSamplePkgPlugin의 기능을 테스트합니다. */
internal class DaegeunSamplePkgPluginTest {

    private lateinit var plugin: DaegeunSamplePkgPlugin
    private lateinit var methodChannel: MethodChannel
    private lateinit var result: MethodChannel.Result

    /** 각 테스트를 실행하기 전에 호출되는 메소드입니다. 이 메소드에서는 테스트에 필요한 객체를 초기화합니다. */
    @BeforeTest
    fun setUp() {
        plugin = DaegeunSamplePkgPlugin()
        methodChannel = Mockito.mock(MethodChannel::class.java)
        result = Mockito.mock(MethodChannel.Result::class.java)
    }

    /** SDK 버전 체크를 테스트하는 메소드입니다. */
    @Test
    fun testSdkVersionCheck() {
        assert(android.os.Build.VERSION.SDK_INT == 0)
    }

    /** getPlatformVersion 메소드가 올바른 버전을 반환하는지 테스트하는 메소드입니다. */
    @Test
    fun getPlatformVersionReturnsCorrectVersion() {
        val methodCall = MethodCall("getPlatformVersion", null)
        plugin.onMethodCall(methodCall, result)
        Mockito.verify(result).success("Android " + android.os.Build.VERSION.RELEASE)
    }

    /** getLocalTimeZone 메소드가 올바른 타임존을 반환하는지 테스트하는 메소드입니다. */
    @Test
    fun getLocalTimeZoneReturnsCorrectTimeZone() {
        val methodCall = MethodCall("getLocalTimeZone", null)
        plugin.onMethodCall(methodCall, result)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            Mockito.verify(result).success(ZoneId.systemDefault().id)
        } else {
            Mockito.verify(result).success(TimeZone.getDefault().id)
        }
    }

    /** getAvailableTimeZones 메소드가 올바른 타임존 목록을 반환하는지 테스트하는 메소드입니다. */
    @Test
    fun getAvailableTimeZonesReturnsCorrectTimeZones() {
        val methodCall = MethodCall("getAvailableTimeZones", null)
        plugin.onMethodCall(methodCall, result)
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            Mockito.verify(result).success(ZoneId.getAvailableZoneIds().toCollection(ArrayList()))
        } else {
            Mockito.verify(result).success(TimeZone.getAvailableIDs().toCollection(ArrayList()))
        }
    }

    /** 구현되지 않은 메소드가 호출될 때 notImplemented를 반환하는지 테스트하는 메소드입니다. */
    @Test
    fun unimplementedMethodReturnsNotImplemented() {
        val methodCall = MethodCall("unimplementedMethod", null)
        plugin.onMethodCall(methodCall, result)
        Mockito.verify(result).notImplemented()
    }
}

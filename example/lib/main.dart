import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:daegeun_sample_pkg/daegeun_sample_pkg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _localTimeZone = "Unknown";
  List<String>? _availableTimeZones = [];
  final _daegeunSamplePkgPlugin = DaegeunSamplePkg();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initLocalTimezoneState();
    initAvailableTimeZonesState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _daegeunSamplePkgPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initLocalTimezoneState() async {
    String localTimeZone;
    try {
      localTimeZone = await _daegeunSamplePkgPlugin.getLocalTimeZone() ??
          "Unknown local timezone";
    } on PlatformException {
      localTimeZone = 'Failed to get local timezone.';
    }

    if (!mounted) return;

    setState(() {
      _localTimeZone = localTimeZone;
    });
  }

  Future<void> initAvailableTimeZonesState() async {
    List<String> availableTimeZones;
    try {
      availableTimeZones =
          await _daegeunSamplePkgPlugin.getAvailableTimeZones() ?? [];
    } on PlatformException {
      availableTimeZones = ['Failed to get available timezones.'];
    }

    if (!mounted) return;

    setState(() {
      _availableTimeZones = availableTimeZones;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('Local TimeZone: $_localTimeZone\n'),
              Text('Available TimeZones: $_availableTimeZones\n')
            ],
          ),
        ),
      ),
    );
  }
}

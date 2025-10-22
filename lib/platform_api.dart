import 'dart:io';
import 'package:flutter/services.dart' show MethodChannel;
import 'package:permission_handler/permission_handler.dart';

const String platformApiChannel = 'com.edutech.quiz_generator/platform-api';

/// Provides platform-native values that are required by the app.
///
/// Directories follow the FreeDesktop XDG specification
///
/// Note: The user must have read/write permission to every returned directory.
abstract class PlatformApi {
  /// The base directory for filesystem operations.
  /// It is a directory shared with other applications and processes.
  Future<Directory> baseDirectory();

  /// The directory in which configuration data (such SharedPreferences) are saved.
  Future<Directory> configDirectory();

  /// The directory in which persistent state files (eg DBs) are saved.
  Future<Directory> stateDirectory();
}

class AndroidApi implements PlatformApi {
  static bool _initialized = false;
  static const platform = MethodChannel(platformApiChannel);

  Future<bool> _initialize() async {
    _initialized = (await Permission.manageExternalStorage.request()).isGranted;
    print("[initialize] $_initialized");
    return _initialized;
  }

  @override
  Future<Directory> baseDirectory() async {
    print("[baseDirectory]");
    if (!_initialized) await _initialize();
    var dir = (await platform.invokeMethod<String>("getSharedDirectory"))!;
    return Directory(dir);
  }

  @override
  Future<Directory> configDirectory() async {
    print("[configDirectory]");
    if (!_initialized) await _initialize();
    return await stateDirectory();
  }

  @override
  Future<Directory> stateDirectory() async {
    print("[stateDirectory]");
    if (!_initialized) await _initialize();
    var privDir = await platform.invokeMethod<String>("getPrivateDirectory");
    return Directory(privDir!);
  }
}

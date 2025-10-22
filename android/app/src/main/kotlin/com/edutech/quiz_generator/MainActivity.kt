package com.edutech.quiz_generator

import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.edutech.quiz_generator/platform-api"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            when (call.method) {
                 "getExternalFilesDirectory" -> {
                     result.success(getExternalFilesDirectory(call.argument<String>("type")))
                 }

                "getPrivateDirectory" -> {
                    result.success(getPrivateDirectory())
                }

                "getSharedDirectory" -> {
                    result.success(getSharedDirectory())
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun getExternalFilesDirectory(type: String?): String {
        return this.getExternalFilesDir(type)!!.absolutePath
    }

    private fun getPrivateDirectory(): String {
       return this.filesDir.absolutePath
    }

    private fun getSharedDirectory(): String {
        return Environment.getExternalStorageDirectory().absolutePath
    }
}

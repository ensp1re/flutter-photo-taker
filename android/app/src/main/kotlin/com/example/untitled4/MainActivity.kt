package com.example.untitled4

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.untitled4/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        // Ensure that the BinaryMessenger is correctly passed to the MethodChannel
        val flutterEngine = flutterEngine ?: return
        val dartExecutor: DartExecutor = flutterEngine.dartExecutor

        MethodChannel(dartExecutor, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                if (call.method == "getCurrentDate") {
                    val currentDate = SimpleDateFormat("dd.MM.yyyy", Locale.getDefault()).format(Date())
                    result.success(currentDate)
                } else {
                    result.notImplemented()
                }
            }
        }
    }
}

package com.example.flutter_native_webview_demo;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.io/webview";

  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    new MethodChannel(getFlutterEngine().getDartExecutor(), CHANNEL).setMethodCallHandler(
      new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, MethodChannel.Result result) {
          if (call.method.equals("openUrl")) {
              openWebView((String)call.arguments);
              result.success(null);
          } else {
              result.notImplemented();
          }
        }
      });
  }

  private void openWebView(String url) {
    Intent intent = new Intent(this, WebActivity.class);
    intent.putExtra("OPEN_WEBVIEW", url);
    Log.d(getClass().getSimpleName(), url);
    startActivity(intent);
  }

}

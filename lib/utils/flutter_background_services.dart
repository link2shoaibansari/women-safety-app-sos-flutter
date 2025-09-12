// Dummy background services shim
// This file intentionally provides no-op implementations for background
// services, messaging and location so the app can run as a dummy UI-only
// application without external platform plugins.

import 'dart:async';

// Keep method signatures so callers don't break.
Future<void> initializeService() async {
  // no-op: background services removed for dummy app
  return Future.value();
}

sendMessage(String messageBody) async {
  // no-op: in dummy mode we won't send messages
  return Future.value();
}

// Expose a simple stream that could be used by UI to simulate location if needed.
Stream<Map<String, double>> getDummyLocationStream() async* {
  // yields a fixed dummy coordinate once per minute (not started by default)
  yield {'latitude': 0.0, 'longitude': 0.0};
}

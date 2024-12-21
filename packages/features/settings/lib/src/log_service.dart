

import 'dart:ui';

class LogService {
  static final List<String> _logs = [];
  static final Set<String> _uniqueLogs = {};
  static final List<VoidCallback> _listeners = [];

  static bool isEnabled = false;

  static void addLog(String log) {
    if (_uniqueLogs.add(log)) { // Only add log if it's unique
      _logs.add(log);
      for (var listener in _listeners) {
        listener();
      }
    }
  }

  static List<String> getLogs() => _logs;

  static void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static void clearLogs() {
    _logs.clear();
    _uniqueLogs.clear();
  }
}
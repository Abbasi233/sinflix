import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/error_widget.dart';

class GlobalErrorHandler {
  static GlobalKey<NavigatorState>? _navigatorKey;

  static void initialize(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  static BuildContext? get _context {
    return _navigatorKey?.currentContext;
  }

  static Future<void> showErrorDialog({
    String? titleKey,
    String? messageKey,
    VoidCallback? onRetry,
    bool dismissible = true,
    bool recordError = false,
    dynamic error,
    StackTrace? stackTrace,
    String? reason,
    Map<String, dynamic>? additionalData,
  }) async {
    final context = _context;
    if (context == null) return;

    if (recordError && error != null) {
      GlobalErrorHandler.recordError(
        error,
        stackTrace,
        reason: reason,
        additionalData: additionalData,
      );
    }

    await showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: AppErrorWidget(
          titleKey: titleKey,
          messageKey: messageKey,
          onRetry: onRetry != null
              ? () {
                  Navigator.of(context).pop();
                  onRetry();
                }
              : null,
          backgroundColor: Colors.transparent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('close'.tr()),
          ),
        ],
      ),
    );
  }

  static void showErrorSnackBar({
    String? messageKey,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onRetry,
    bool recordError = false,
    dynamic error,
    StackTrace? stackTrace,
    String? reason,
    Map<String, dynamic>? additionalData,
  }) {
    final context = _context;
    if (context == null) return;

    if (recordError && error != null) {
      GlobalErrorHandler.recordError(
        error,
        stackTrace,
        reason: reason,
        additionalData: additionalData,
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                messageKey?.tr() ?? 'error.something_went_wrong'.tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: onRetry != null
            ? SnackBarAction(
                label: 'error.retry'.tr(),
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }

  static void recordError(
    dynamic error,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? additionalData,
    bool fatal = false,
  }) {
    try {
      log(
        'Error recorded: $error',
        name: 'GlobalErrorHandler',
        error: error,
        stackTrace: stackTrace,
      );

      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: reason ?? 'Uncaught exception',
        fatal: fatal,
        information: additionalData?.entries.map((e) => DiagnosticsProperty(e.key, e.value)).toList() ?? [],
      );

      if (additionalData != null) {
        for (final entry in additionalData.entries) {
          FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
        }
      }
    } catch (e) {
      log('Failed to record error to Crashlytics: $e', name: 'GlobalErrorHandler');
    }
  }

  static void handleError(
    dynamic error, {
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
    bool showUI = true,
    bool recordError = true,
    String? reason,
  }) {
    if (!showUI) return;

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network') || errorString.contains('connection') || errorString.contains('internet') || errorString.contains('socket')) {
      showErrorDialog(
        titleKey: 'error.network_error_title',
        messageKey: 'error.network_error_message',
        recordError: recordError,
        error: error,
        stackTrace: stackTrace,
        reason: reason ?? 'Network error',
        additionalData: additionalData,
      );
    } else if (errorString.contains('server') || errorString.contains('500') || errorString.contains('503') || errorString.contains('502')) {
      showErrorDialog(
        titleKey: 'error.server_error_title',
        messageKey: 'error.server_error_message',
        recordError: recordError,
        error: error,
        stackTrace: stackTrace,
        reason: reason ?? 'Server error',
        additionalData: additionalData,
      );
    } else if (errorString.contains('404') || errorString.contains('not found')) {
      showErrorDialog(
        titleKey: 'error.not_found_error_title',
        messageKey: 'error.not_found_error_message',
        recordError: recordError,
        error: error,
        stackTrace: stackTrace,
        reason: reason ?? 'Content not found',
        additionalData: additionalData,
      );
    } else {
      showErrorSnackBar(
        messageKey: error.toString(),
        recordError: recordError,
        error: error,
        stackTrace: stackTrace,
        reason: reason ?? 'Unknown error',
        additionalData: additionalData,
      );
    }
  }

  static void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    try {
      FirebaseCrashlytics.instance.log('$eventName: ${parameters?.toString() ?? ''}');

      if (parameters != null) {
        for (final entry in parameters.entries) {
          FirebaseCrashlytics.instance.setCustomKey(entry.key, entry.value);
        }
      }
    } catch (e) {
      log('Failed to log event to Crashlytics: $e', name: 'GlobalErrorHandler');
    }
  }

  static void setUserInfo({
    required String userId,
    String? email,
    String? username,
  }) {
    try {
      FirebaseCrashlytics.instance.setUserIdentifier(userId);

      if (email != null) {
        FirebaseCrashlytics.instance.setCustomKey('user_email', email);
      }

      if (username != null) {
        FirebaseCrashlytics.instance.setCustomKey('user_name', username);
      }
    } catch (e) {
      log('Failed to set user info in Crashlytics: $e', name: 'GlobalErrorHandler');
    }
  }
}

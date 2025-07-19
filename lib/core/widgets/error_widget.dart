import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AppErrorWidget extends StatelessWidget {
  final String? titleKey;
  final String? messageKey;
  final IconData? icon;
  final VoidCallback? onRetry;
  final bool showRetryButton;
  final Color? backgroundColor;

  const AppErrorWidget({
    super.key,
    this.titleKey,
    this.messageKey,
    this.icon,
    this.onRetry,
    this.showRetryButton = true,
    this.backgroundColor,
  });

  const AppErrorWidget.simple(
    String msg, {
    Key? key,
    VoidCallback? onRetry,
  }) : this(
         key: key,
         messageKey: msg,
         onRetry: onRetry,
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            titleKey?.tr() ?? 'error.error_occurred'.tr(),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            messageKey?.tr() ?? 'error.something_went_wrong'.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text('error.retry'.tr()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class NetworkErrorWidget extends AppErrorWidget {
  const NetworkErrorWidget({
    super.key,
    super.onRetry,
  }) : super(
         titleKey: 'error.network_error_title',
         messageKey: 'error.network_error_message',
         icon: Icons.wifi_off,
       );
}

class ServerErrorWidget extends AppErrorWidget {
  const ServerErrorWidget({
    super.key,
    super.onRetry,
  }) : super(
         titleKey: 'error.server_error_title',
         messageKey: 'error.server_error_message',
         icon: Icons.cloud_off,
       );
}

class NotFoundErrorWidget extends AppErrorWidget {
  const NotFoundErrorWidget({
    super.key,
    super.onRetry,
  }) : super(
         titleKey: 'error.not_found_error_title',
         messageKey: 'error.not_found_error_message',
         icon: Icons.search_off,
         showRetryButton: false,
       );
}

class UnknownErrorWidget extends AppErrorWidget {
  const UnknownErrorWidget({
    super.key,
    super.showRetryButton = false,
    String? customMessage,
  }) : super(
         titleKey: 'error.unknown_error_title',
         messageKey: customMessage ?? 'error.unknown_error_message',
         icon: Icons.bug_report,
       );
}

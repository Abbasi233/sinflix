import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

import '/core/asset_paths.dart';
import '/core/extensions.dart';

class LoadingWidget {
  static OverlayEntry? _current;

  static void show(BuildContext context, {String? message}) {
    if (_current != null) return;
    _current = OverlayEntry(
      builder: (ctx) => Stack(
        fit: StackFit.loose,
        children: [
          const ModalBarrier(dismissible: false, color: Colors.black54),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.theme.colorScheme.surfaceContainerHighest.withValues(alpha: .8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AssetPaths.loadingAnimation,
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    message ?? 'keywords.loading'.tr(),
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    context.callAfterBuild(() => Overlay.of(context).insert(_current!));
  }

  static void hide() {
    _current?.remove();
    _current = null;
  }
}

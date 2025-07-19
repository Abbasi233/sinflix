import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/extensions.dart';

class AppRefreshIndicator extends StatefulWidget {
  const AppRefreshIndicator({
    required this.child,
    required this.onRefresh,
    this.onLoading,
    super.key,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final Future<bool> Function()? onLoading;

  @override
  State<AppRefreshIndicator> createState() => _AppRefreshIndicatorState();
}

class _AppRefreshIndicatorState extends State<AppRefreshIndicator> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: MaterialClassicHeader(color: context.theme.colorScheme.primary, backgroundColor: context.theme.colorScheme.surfaceContainerHighest),
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingText: '',
        idleText: '',
        canLoadingText: '',
        noDataText: '',
      ),
      enablePullDown: true,
      enablePullUp: widget.onLoading != null,
      onRefresh: () async {
        _refreshController.resetNoData();
        await widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: widget.onLoading != null
          ? () async {
              bool isNewData = await widget.onLoading!();
              if (isNewData) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
            }
          : null,
      child: widget.child,
    );
  }
}

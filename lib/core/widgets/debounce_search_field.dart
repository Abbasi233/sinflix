import 'dart:async';
import 'package:flutter/material.dart';

class DebounceSearchField extends StatefulWidget {
  final Function(String) onChanged;
  final String? hintText;
  final Duration debounceDuration;

  const DebounceSearchField({
    required this.onChanged,
    this.hintText = 'Ara',
    this.debounceDuration = const Duration(milliseconds: 500),
    super.key,
  });

  @override
  State<DebounceSearchField> createState() => _DebounceSearchFieldState();
}

class _DebounceSearchFieldState extends State<DebounceSearchField> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: _onSearchChanged,
    );
  }
}

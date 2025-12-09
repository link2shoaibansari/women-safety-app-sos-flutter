import 'dart:convert';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// A small floating helper (iHelp) button that sits in the bottom-right corner.
/// Tap to open a simple help dialog. Keep this intentionally lightweight so it
/// works without any backend.
class IHelpWidget extends StatefulWidget {
  final double size;
  const IHelpWidget({Key? key, this.size = 56}) : super(key: key);

  @override
  State<IHelpWidget> createState() => _IHelpWidgetState();
}

class _IHelpWidgetState extends State<IHelpWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openHelp() async {
    // small pulse animation
    await _controller.forward();
    await _controller.reverse();

    final message = await showDialog<String>(
      context: context,
      builder: (ctx) => _IHelpInputDialog(),
    );

    if (message == null || message.trim().isEmpty) return;

    // show progress while waiting for reply
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: SizedBox(
          height: 80,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );

    final reply = await _sendToBackend(message);

    // dismiss progress
    if (Navigator.canPop(context)) Navigator.of(context).pop();

    // show reply
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('iHelp — Reply'),
        content: Text(reply),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close')),
        ],
      ),
    );
  }

  Future<String> _sendToBackend(String message) async {
    // Build candidate base URLs depending on platform. We avoid dart:io import to keep web compatible.
    final candidates = <String>[];
    if (kIsWeb) {
      candidates.add('http://localhost:9090');
      candidates.add('http://localhost:8080');
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      // Android emulator accesses host via 10.0.2.2
      candidates.add('http://10.0.2.2:9090');
      candidates.add('http://10.0.2.2:8080');
      candidates.add('http://localhost:9090');
      candidates.add('http://localhost:8080');
    } else {
      // Desktop or iOS simulator
      candidates.add('http://localhost:9090');
      candidates.add('http://localhost:8080');
      candidates.add('http://10.0.2.2:9090');
      candidates.add('http://10.0.2.2:8080');
    }

    for (final base in candidates) {
      try {
        final uri = Uri.parse('$base/chat');
        final resp = await http
            .post(uri,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'message': message}))
            .timeout(const Duration(seconds: 8));
        if (resp.statusCode == 200) {
          final body = jsonDecode(resp.body);
          return body['reply'] ?? 'No reply';
        }
      } catch (_) {
        // try next candidate
        continue;
      }
    }

    return 'Could not reach iHelp server. Make sure the server is running on your machine and that emulator/network settings allow connecting to it.';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ScaleTransition(
            scale: _scale,
            child: Material(
              color: Colors.pink,
              elevation: 6,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _openHelp,
                onHover: (h) {
                  if (h)
                    _controller.forward();
                  else
                    _controller.reverse();
                },
                child: SizedBox(
                  height: widget.size,
                  width: widget.size,
                  child: const Center(
                    child: Icon(
                      Icons.help_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IHelpInputDialog extends StatefulWidget {
  @override
  State<_IHelpInputDialog> createState() => _IHelpInputDialogState();
}

class _IHelpInputDialogState extends State<_IHelpInputDialog> {
  final _ctrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ask iHelp'),
      content: TextField(
        controller: _ctrl,
        decoration: const InputDecoration(hintText: 'Type your question'),
        minLines: 1,
        maxLines: 4,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _sending
              ? null
              : () {
                  Navigator.of(context).pop(_ctrl.text.trim());
                },
          child: const Text('Send'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/network_bloc.dart';
import '../bloc/network_state.dart';
import 'network_error_screen.dart';

/// Network Aware Widget
/// Wraps the entire app and handles automatic navigation based on network status
class NetworkAwareWidget extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const NetworkAwareWidget({super.key, required this.child, required this.navigatorKey});

  @override
  State<NetworkAwareWidget> createState() => _NetworkAwareWidgetState();
}

class _NetworkAwareWidgetState extends State<NetworkAwareWidget> {
  bool _isShowingNetworkError = false;
  String? _lastConnectionType;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          _showNetworkError(context);
        } else if (state is NetworkConnected) {
          _hideNetworkError(context);
          _showConnectionRestoredSnackbar(context, state.connectionType);
        } else if (state is NetworkConnectionTypeChanged) {
          _showConnectionTypeChangedSnackbar(context, state.previousType, state.currentType);
        }
      },
      child: widget.child,
    );
  }

  /// Show network error screen
  void _showNetworkError(BuildContext context) {
    if (!_isShowingNetworkError) {
      _isShowingNetworkError = true;

      // Use post-frame callback to ensure navigation happens after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _isShowingNetworkError && widget.navigatorKey.currentState != null) {
          widget.navigatorKey.currentState!.push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const NetworkErrorScreen();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
              fullscreenDialog: true,
            ),
          );
        }
      });
    }
  }

  /// Hide network error screen
  void _hideNetworkError(BuildContext context) {
    if (_isShowingNetworkError) {
      _isShowingNetworkError = false;

      // Use post-frame callback to ensure navigation happens after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.navigatorKey.currentState != null) {
          try {
            if (widget.navigatorKey.currentState!.canPop()) {
              widget.navigatorKey.currentState!.pop();
            }
          } catch (e) {
            debugPrint('Error hiding network error screen: $e');
          }
        }
      });
    }
  }

  /// Show connection restored snackbar
  void _showConnectionRestoredSnackbar(BuildContext context, String connectionType) {
    // Only show if we previously lost connection
    if (_lastConnectionType == null || _lastConnectionType == 'none') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text('Connected to $connectionType', style: const TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
    _lastConnectionType = connectionType;
  }

  /// Show connection type changed snackbar
  void _showConnectionTypeChangedSnackbar(BuildContext context, String previousType, String currentType) {
    _lastConnectionType = currentType;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.swap_horiz, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Connection changed: $previousType → $currentType',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

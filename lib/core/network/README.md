# Network Monitoring Module

## 📡 Overview

This module provides real-time network connectivity monitoring for the entire application. It automatically detects network changes and handles navigation based on connectivity status.

---

## ✨ Features

- ✅ **Real-time monitoring** of network connectivity
- ✅ **Automatic navigation** to error screen when disconnected
- ✅ **Auto-recovery** when connection is restored
- ✅ **Connection type detection** (WiFi, Mobile Data, Ethernet, VPN, etc.)
- ✅ **Connection change notifications** (WiFi ↔ Mobile Data)
- ✅ **Beautiful error screen** with helpful tips
- ✅ **Application-wide** coverage

---

## 📂 Module Structure

```
lib/core/network/
├── bloc/
│   ├── network_bloc.dart       # BLoC managing network state
│   ├── network_event.dart      # Network events (Start/Stop monitoring, etc.)
│   └── network_state.dart      # Network states (Connected/Disconnected/Changed)
├── presentation/
│   ├── network_error_screen.dart    # Error screen UI
│   └── network_aware_widget.dart    # Global network listener widget
└── README.md                   # This file
```

---

## 🔧 Implementation

### 1. BLoC Layer

**`network_bloc.dart`**
- Listens to connectivity changes via `connectivity_plus` package
- Emits appropriate states based on network status
- Tracks connection type transitions

**States:**
- `NetworkInitial` - Initial state when app starts
- `NetworkConnected` - Device has internet connection
- `NetworkDisconnected` - No internet connection
- `NetworkConnectionTypeChanged` - Connection type switched

**Events:**
- `StartNetworkMonitoring` - Begin monitoring
- `NetworkConnectivityChanged` - Internal event on connectivity change
- `StopNetworkMonitoring` - Stop monitoring

### 2. Presentation Layer

**`network_error_screen.dart`**
- Beautiful, animated error screen shown when network is lost
- Prevents back navigation (WillPopScope)
- Shows helpful troubleshooting tips
- Automatically dismisses when connection is restored

**`network_aware_widget.dart`**
- Wraps the entire MaterialApp
- Listens to NetworkBloc states
- Handles automatic navigation:
  - Shows error screen on disconnect
  - Dismisses error screen on reconnect
  - Shows snackbars for connection changes

---

## 🎯 Connection Types Detected

| Type | Description | Priority |
|------|-------------|----------|
| WiFi | Wireless network | Highest |
| Ethernet | Wired connection | High |
| Mobile | Cellular (3G/4G/5G) | Medium |
| VPN | Virtual Private Network | Low |
| Bluetooth | Bluetooth connection | Low |
| Other | Unknown connection | Lowest |
| None | Disconnected | - |

---

## 🚀 Usage

### Already Integrated!

The network monitoring is already set up in `main.dart`:

```dart
MultiBlocProvider(
  providers: [
    // ... other BLoCs
    BlocProvider(
      create: (_) => NetworkBloc()..add(const StartNetworkMonitoring()),
    ),
  ],
  // ...
)

// MaterialApp with NetworkAwareWidget in builder
return MaterialApp(
  // ... other properties
  builder: (context, child) {
    return NetworkAwareWidget(child: child ?? const SizedBox.shrink());
  },
  // ...
);
```

**Important**: NetworkAwareWidget must be inside MaterialApp's `builder` property, not wrapping MaterialApp. This ensures the Navigator context is available.

### Manual Access (Optional)

If you need to check network status manually in any widget:

```dart
// Listen to network state
BlocBuilder<NetworkBloc, NetworkState>(
  builder: (context, state) {
    if (state is NetworkConnected) {
      return Text('Connected to ${state.connectionType}');
    } else if (state is NetworkDisconnected) {
      return Text('No connection');
    }
    return Text('Checking...');
  },
)

// Or use listener for side effects
BlocListener<NetworkBloc, NetworkState>(
  listener: (context, state) {
    if (state is NetworkDisconnected) {
      // Handle disconnection
    }
  },
  child: YourWidget(),
)
```

---

## 🧪 Testing

### Test Scenarios

1. **Network Disconnection**
   ```
   Action: Turn off WiFi
   Expected: Network Error Screen appears immediately
   ```

2. **Network Restoration**
   ```
   Action: Turn on WiFi
   Expected: Error screen dismisses, green snackbar shows "Connected to WiFi"
   ```

3. **Connection Type Change**
   ```
   Action: Switch from WiFi to Mobile Data
   Expected: Orange snackbar shows "Connection changed: WiFi → Mobile Data"
   ```

4. **Airplane Mode**
   ```
   Action: Enable Airplane Mode
   Expected: Error screen appears
   Action: Disable Airplane Mode
   Expected: Error screen dismisses when connected
   ```

---

## 🎨 User Experience Flow

### When Network is Lost:
1. User is on any screen
2. Network disconnects
3. **Instantly**: Network Error Screen slides up
4. User sees troubleshooting tips
5. "Waiting for connection..." indicator shows

### When Network is Restored:
1. Connection comes back
2. **Instantly**: Error screen dismisses
3. User returns to previous screen
4. Green snackbar: "Connected to [WiFi/Mobile Data]"

### When Connection Type Changes:
1. Switch from WiFi to Mobile Data (or vice versa)
2. Orange snackbar: "Connection changed: WiFi → Mobile Data"
3. App continues normally

---

## 🎛️ Customization

### Modify Error Screen Message

Edit `presentation/network_error_screen.dart`:

```dart
Text(
  'Your custom title here',
  style: Theme.of(context).textTheme.headlineMedium,
),
```

### Change Snackbar Messages

Edit `presentation/network_aware_widget.dart`:

```dart
// Connection restored message
Text('Your custom message: Connected to $connectionType'),

// Connection type changed message
Text('Your custom message: $previousType → $currentType'),
```

### Customize Error Screen Colors

Edit `presentation/network_error_screen.dart`:

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.yourColor1,  // Change these
        Colors.yourColor2,
      ],
    ),
  ),
  // ...
)
```

---

## 📊 State Diagram

```
         [App Start]
              ↓
      NetworkInitial
              ↓
    [Check Connectivity]
         ↙        ↘
  Connected    Disconnected
      ↓              ↓
 Show App    Show Error Screen
      ↓              ↓
[Monitor]      [Wait & Monitor]
      ↓              ↓
Type Changed   Connection Restored
      ↓              ↓
Show Snackbar   Dismiss Error
      ↓              ↓
  Continue    Return to App
```

---

## 🔍 Troubleshooting

### Network changes not detected

**Cause**: NetworkBloc not started  
**Solution**: Ensure in `main.dart`:
```dart
BlocProvider(
  create: (_) => NetworkBloc()..add(const StartNetworkMonitoring()),
)
```

### Error screen not appearing

**Cause**: NetworkAwareWidget not wrapping MaterialApp  
**Solution**: Check `main.dart`:
```dart
return NetworkAwareWidget(
  child: MaterialApp(...),
);
```

### Snackbars not showing

**Cause**: No Scaffold in current route  
**Solution**: Ensure your screens have a Scaffold widget

### Back button appears on error screen

**This is prevented!** WillPopScope is used to block back navigation when offline.

---

## 📦 Dependencies

- **connectivity_plus: ^6.1.0**
  - Cross-platform connectivity monitoring
  - Real-time stream of network changes
  - Supports all connection types

---

## 🚀 Future Enhancements

- [ ] Network speed/quality detection
- [ ] Offline mode with local caching
- [ ] Automatic retry mechanism
- [ ] Network analytics and monitoring
- [ ] Customizable retry strategies

---

## 📝 Notes

- The module automatically starts monitoring when the app launches
- Monitoring continues throughout the app lifecycle
- The NetworkBloc is properly disposed when the app closes
- Error screen uses root navigator to ensure it appears over all screens
- Connection type priority ensures best connection is reported

---

## ✅ Checklist for Integration

- [x] Added `connectivity_plus` to `pubspec.yaml`
- [x] Created NetworkBloc with states and events
- [x] Created NetworkErrorScreen
- [x] Created NetworkAwareWidget
- [x] Added NetworkBloc to BLoC providers
- [x] Wrapped MaterialApp with NetworkAwareWidget
- [x] Tested network disconnection
- [x] Tested network restoration
- [x] Tested connection type changes

---

## 👤 Usage Examples

### Example 1: Check if connected before API call

```dart
final networkState = context.read<NetworkBloc>().state;
if (networkState is NetworkConnected) {
  // Safe to make API call
  await apiService.fetchData();
} else {
  // Show offline message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('No internet connection')),
  );
}
```

### Example 2: Show different UI based on connection type

```dart
BlocBuilder<NetworkBloc, NetworkState>(
  builder: (context, state) {
    if (state is NetworkConnected) {
      if (state.connectionType == 'WiFi') {
        return HighQualityVideoWidget();
      } else {
        return LowQualityVideoWidget(); // Save mobile data
      }
    }
    return OfflineWidget();
  },
)
```

---

**Module Version**: 1.0.0  
**Created**: 2025-12-17  
**Last Updated**: 2025-12-17

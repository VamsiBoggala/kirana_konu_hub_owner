import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/routes/app_routes.dart';
import 'package:hub_owner/l10n/app_localizations.dart';
import 'core/localization/bloc/language_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/registration/presentation/bloc/registration_bloc.dart';
import 'core/network/bloc/network_bloc.dart';
import 'core/network/bloc/network_event.dart';
import 'core/network/presentation/network_aware_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp();
    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('❌ Firebase initialization error: $e');
    // Still run the app, but user will see errors when trying to authenticate
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Global key for Navigator access
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => RegistrationBloc()),
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => NetworkBloc()..add(const StartNetworkMonitoring())),
      ],
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return MaterialApp(
                  title: 'Kirana Konu - Hub Owner',
                  debugShowCheckedModeBanner: false,

                  // Localization
                  locale: locale,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,

                  // Theme Configuration
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeProvider.themeMode,

                  // Network Monitoring - wrap the entire app
                  builder: (context, child) {
                    return NetworkAwareWidget(navigatorKey: navigatorKey, child: child ?? const SizedBox.shrink());
                  },

                  // Navigator Key for global access
                  navigatorKey: navigatorKey,

                  // Routing Configuration
                  initialRoute: AppRoutes.getInitialRoute(),
                  onGenerateRoute: AppRoutes.onGenerateRoute,

                  // Unknown route handler (404)
                  onUnknownRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: const Text('Error')),
                        body: Center(
                          child: Text('Page not found: ${settings.name}', style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

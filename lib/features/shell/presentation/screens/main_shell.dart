import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/active_sounds_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/floating_nav_bar.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../sounds/presentation/screens/sounds_screen.dart';
import '../../../sounds/presentation/widgets/mini_player_bar.dart';
import '../../../sounds/presentation/screens/current_mix_screen.dart';
import '../../../breathwork/presentation/screens/breathwork_screen.dart';
import '../../../library/presentation/screens/library_screen.dart';

/// Main app shell with floating navbar + global mini player.
///
/// Manages tab navigation between Home, Sounds, Breathwork, Library, Settings.
/// MiniPlayerBar appears above navbar when sounds are active (any tab).
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int _currentIndex = 0;

  // Tab screens
  final List<Widget> _screens = const [
    HomeScreen(),
    SoundsScreen(),
    BreathworkScreen(),
    LibraryScreen(),
    _PlaceholderScreen(title: 'Settings', icon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final activeSoundsState = ref.watch(activeSoundsProvider);
    final hasActive = activeSoundsState.hasActiveSounds;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Tab Content ───────────────────────────────────
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // ── Mini Player + Navbar (bottom) ─────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Mini player (conditional)
                if (hasActive)
                  MiniPlayerBar(
                    count: activeSoundsState.count,
                    labels: activeSoundsState.labels,
                    isPlaying: activeSoundsState.isPlaying,
                    onPlayPause: () {
                      ref
                          .read(activeSoundsProvider.notifier)
                          .togglePlayback();
                    },
                    onExpand: () {
                      CurrentMixScreen.show(context);
                    },
                  ),

                // Navbar (always visible)
                FloatingNavBar(
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() => _currentIndex = index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Temporary placeholder for tabs not yet implemented.
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF0D1B2A), AppColors.background],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.accent.withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

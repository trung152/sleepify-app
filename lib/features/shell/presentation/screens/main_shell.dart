import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/floating_nav_bar.dart';
import '../../../home/presentation/screens/home_screen.dart';

/// Main app shell with floating navbar.
///
/// Manages tab navigation between Home, Sounds, Breathwork, Library, Settings.
/// Each tab preserves its own state via IndexedStack.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Tab screens — placeholder screens for non-Home tabs
  final List<Widget> _screens = const [
    HomeScreen(),
    _PlaceholderScreen(title: 'Sounds', icon: Icons.graphic_eq),
    _PlaceholderScreen(title: 'Breathwork', icon: Icons.air),
    _PlaceholderScreen(title: 'Library', icon: Icons.bookmark),
    _PlaceholderScreen(title: 'Settings', icon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Tab Content ───────────────────────────────────
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // ── Floating Navbar ──────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
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

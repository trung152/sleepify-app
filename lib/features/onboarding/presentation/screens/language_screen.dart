import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/providers/locale_provider.dart';
import '../../../../core/theme/app_colors.dart';

/// Language selection screen — first step of onboarding.
///
/// Displays a list of supported languages with flags.
/// Selecting a language changes the app locale immediately.
class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  String _selectedCode = 'en';

  static const List<_LanguageItem> _languages = [
    _LanguageItem(code: 'en', name: 'English (UK)', flag: '🇬🇧'),
    _LanguageItem(code: 'fr', name: 'French', flag: '🇫🇷'),
    _LanguageItem(code: 'de', name: 'German', flag: '🇩🇪'),
    _LanguageItem(code: 'ja', name: 'Japanese', flag: '🇯🇵'),
    _LanguageItem(code: 'es', name: 'Spanish', flag: '🇪🇸'),
    _LanguageItem(code: 'vi', name: 'Vietnamese', flag: '🇻🇳'),
    _LanguageItem(code: 'it', name: 'Italian', flag: '🇮🇹'),
    _LanguageItem(code: 'ko', name: 'Korean', flag: '🇰🇷'),
  ];

  @override
  void initState() {
    super.initState();
    // Read current locale from provider
    final currentLocale = ref.read(localeProvider);
    if (currentLocale != null) {
      _selectedCode = currentLocale.languageCode;
    }
  }

  void _onContinue() {
    ref.read(localeProvider.notifier).setLocale(Locale(_selectedCode));
    context.go('/onboarding/goal');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF0D1B2A), AppColors.background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Title
                Text(
                  'Select Language',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 24),

                // Language List
                Expanded(
                  child: ListView.separated(
                    itemCount: _languages.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lang = _languages[index];
                      final isSelected = lang.code == _selectedCode;
                      return _LanguageTile(
                        language: lang,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() => _selectedCode = lang.code);
                        },
                      );
                    },
                  ),
                ),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 24, top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A single language tile with flag, name, and selection indicator.
class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final _LanguageItem language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withValues(alpha: 0.12)
              : AppColors.surface.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.surface.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            // Flag
            Text(language.flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),

            // Name
            Expanded(
              child: Text(
                language.name,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
            ),

            // Check indicator
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.background,
                  size: 16,
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.surface.withValues(alpha: 0.2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Data class for a language item.
class _LanguageItem {
  const _LanguageItem({
    required this.code,
    required this.name,
    required this.flag,
  });

  final String code;
  final String name;
  final String flag;
}

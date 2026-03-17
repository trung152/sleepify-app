import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/audio/sound_registry.dart';
import '../../../../core/theme/app_colors.dart';

/// Session settings — timer duration and ambient sound picker.
///
/// Two pill-shaped buttons matching the Stitch design:
/// - Timer: clock icon + "10 min" + dropdown arrow
/// - Ambient: music icon + sound name + dropdown arrow
class SessionSettings extends StatelessWidget {
  const SessionSettings({
    super.key,
    required this.durationMinutes,
    required this.ambientSoundId,
    required this.onDurationChanged,
    required this.onAmbientChanged,
  });

  final int durationMinutes;
  final String? ambientSoundId;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<String?> onAmbientChanged;

  static const List<int> _durations = [3, 5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    final ambientLabel = ambientSoundId != null
        ? SoundRegistry.getById(ambientSoundId!)?.label ?? 'None'
        : 'None';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Timer pill
        _SettingPill(
          icon: Icons.timer_outlined,
          label: '$durationMinutes min',
          onTap: () => _showDurationPicker(context),
        ),
        const SizedBox(width: 12),

        // Ambient sound pill
        _SettingPill(
          icon: Icons.music_note_rounded,
          label: ambientLabel,
          onTap: () => _showSoundPicker(context),
        ),
      ],
    );
  }

  void _showDurationPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF151D2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Session Duration',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ..._durations.map((d) {
                final isSelected = d == durationMinutes;
                return ListTile(
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: isSelected ? AppColors.accent : AppColors.textSecondary,
                  ),
                  title: Text(
                    '$d minutes',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    onDurationChanged(d);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showSoundPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF151D2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Ambient Sound',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              // "None" option
              ListTile(
                leading: Icon(
                  ambientSoundId == null
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: ambientSoundId == null
                      ? AppColors.accent
                      : AppColors.textSecondary,
                ),
                title: Text(
                  'None',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: ambientSoundId == null
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: ambientSoundId == null
                        ? AppColors.accent
                        : AppColors.textPrimary,
                  ),
                ),
                onTap: () {
                  onAmbientChanged(null);
                  Navigator.pop(context);
                },
              ),
              // Sound options
              ...SoundRegistry.allSounds.map((sound) {
                final isSelected = sound.id == ambientSoundId;
                return ListTile(
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color:
                        isSelected ? AppColors.accent : AppColors.textSecondary,
                  ),
                  title: Text(
                    sound.label,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.textPrimary,
                    ),
                  ),
                  trailing: Icon(
                    sound.icon,
                    size: 20,
                    color: isSelected
                        ? AppColors.accent
                        : AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  onTap: () {
                    onAmbientChanged(sound.id);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

/// Pill-shaped setting button with icon, label, and dropdown arrow.
class _SettingPill extends StatelessWidget {
  const _SettingPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.surface.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.accent),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Bottom sheet for naming and saving the current mix.
///
/// Returns `true` if the user tapped "Save Mix", `null` on cancel.
/// The mix name is returned via [onSave] callback.
class SaveMixBottomSheet extends StatefulWidget {
  const SaveMixBottomSheet({
    super.key,
    required this.onSave,
    this.defaultName,
  });

  final ValueChanged<String> onSave;
  final String? defaultName;

  /// Show the bottom sheet and return whether a save occurred.
  static Future<bool?> show(
    BuildContext context, {
    required ValueChanged<String> onSave,
    String? defaultName,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => SaveMixBottomSheet(
        onSave: onSave,
        defaultName: defaultName,
      ),
    );
  }

  @override
  State<SaveMixBottomSheet> createState() => _SaveMixBottomSheetState();
}

class _SaveMixBottomSheetState extends State<SaveMixBottomSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultName ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    widget.onSave(name);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            decoration: BoxDecoration(
              color: const Color(0xFF111827).withValues(alpha: 0.95),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border(
                top: BorderSide(
                  color: AppColors.surface.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Drag handle ──
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // ── Title ──
                Text(
                  'Save Your Mix',
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 24),

                // ── Label ──
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'MIX NAME',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ── Text field ──
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.surface.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'My Evening Mix',
                      hintStyle: GoogleFonts.manrope(
                        fontSize: 16,
                        color: AppColors.textSecondary.withValues(alpha: 0.3),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.edit_rounded,
                        size: 18,
                        color: AppColors.textSecondary.withValues(alpha: 0.4),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _handleSave(),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Save button ──
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: const Color(0xFF0B0F19),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save Mix',
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Cancel button ──
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
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

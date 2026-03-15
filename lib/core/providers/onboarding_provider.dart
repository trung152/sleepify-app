import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_provider.g.dart';

const String _kOnboardedKey = 'is_onboarded';

/// Tracks whether the user has completed onboarding.
@Riverpod(keepAlive: true)
class OnboardingStatus extends _$OnboardingStatus {
  @override
  bool build() {
    _loadStatus();
    return false; // default: not onboarded
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isOnboarded = prefs.getBool(_kOnboardedKey) ?? false;
    state = isOnboarded;
  }

  Future<void> markOnboarded() async {
    state = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardedKey, true);
  }
}

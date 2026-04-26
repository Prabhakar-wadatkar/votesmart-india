import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votesmart_india/l10n/generated/app_localizations.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../chat/providers/chat_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final session = ref.read(sessionProvider);
      if (session.age != null) _ageController.text = session.age.toString();
      if (session.location != null) _locationController.text = session.location!;
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final isDark = ref.watch(darkModeProvider);
    final locale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final messages = ref.watch(chatMessagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Session card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: GlassDecoration.gradientCard(
              colors: [const Color(0xFFFF9933), const Color(0xFFFF6B00)],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person_rounded, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Session: ${session.sessionId.substring(0, 8)}...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _MiniStat(
                      label: l10n.journeyProgress,
                      value: '${(session.progressPercent * 100).toInt()}%',
                    ),
                    _MiniStat(
                      label: l10n.chatHistory,
                      value: '${messages.length}',
                    ),
                    _MiniStat(
                      label: l10n.eligibilityStatus,
                      value: session.isEligible ? '✅' : '❌',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // User Info Section
          Text(
            l10n.sessionInfo,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: l10n.enterAge,
                      prefixIcon: const Icon(Icons.cake_rounded),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.check_rounded),
                        onPressed: () {
                          final age = int.tryParse(_ageController.text);
                          if (age != null && age > 0 && age < 150) {
                            ref.read(sessionProvider.notifier).updateAge(age);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Age updated!')),
                            );
                          }
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: l10n.enterLocation,
                      prefixIcon: const Icon(Icons.location_on_rounded),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.check_rounded),
                        onPressed: () {
                          final loc = _locationController.text.trim();
                          if (loc.isNotEmpty) {
                            ref
                                .read(sessionProvider.notifier)
                                .updateLocation(loc);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Location updated!')),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Eligibility result
                  if (session.age != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: session.isEligible
                            ? const Color(0xFF138808).withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: session.isEligible
                              ? const Color(0xFF138808).withValues(alpha: 0.3)
                              : Colors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            session.isEligible
                                ? Icons.check_circle_rounded
                                : Icons.pending_rounded,
                            color: session.isEligible
                                ? const Color(0xFF138808)
                                : Colors.orange,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              session.isEligible
                                  ? l10n.eligible
                                  : session.daysUntilEligible != null
                                      ? l10n.daysUntilEligible(
                                          session.daysUntilEligible!)
                                      : l10n.notEligible,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: session.isEligible
                                    ? const Color(0xFF138808)
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Settings Section
          Text(
            l10n.language,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text(l10n.english),
                  value: 'en',
                  groupValue: locale.languageCode,
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(localeProvider.notifier).setLocale(v);
                      ref.read(sessionProvider.notifier).updateLanguage(v);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text(l10n.hindi),
                  value: 'hi',
                  groupValue: locale.languageCode,
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(localeProvider.notifier).setLocale(v);
                      ref.read(sessionProvider.notifier).updateLanguage(v);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text(l10n.marathi),
                  value: 'mr',
                  groupValue: locale.languageCode,
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(localeProvider.notifier).setLocale(v);
                      ref.read(sessionProvider.notifier).updateLanguage(v);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Dark mode toggle
          Card(
            child: SwitchListTile(
              title: Text(l10n.darkMode),
              secondary: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              ),
              value: isDark,
              onChanged: (_) => ref.read(darkModeProvider.notifier).toggle(),
            ),
          ),
          const SizedBox(height: 24),

          // Clear session
          OutlinedButton.icon(
            onPressed: () => _showClearDialog(context, ref, l10n),
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            label: Text(
              l10n.clearSession,
              style: const TextStyle(color: Colors.red),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.clearSession),
        content: Text(l10n.clearSessionConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              ref.read(sessionProvider.notifier).clearSession();
              ref.read(chatMessagesProvider.notifier).clearMessages();
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Session cleared')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

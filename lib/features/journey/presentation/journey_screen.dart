import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votesmart_india/l10n/generated/app_localizations.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/theme/app_theme.dart';

class JourneyScreen extends ConsumerStatefulWidget {
  const JourneyScreen({super.key});

  @override
  ConsumerState<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends ConsumerState<JourneyScreen> {
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final l10n = AppLocalizations.of(context)!;
    final isDark = ref.watch(darkModeProvider);
    final theme = Theme.of(context);

    final steps = _getSteps(l10n);
    final stepKeys = [
      'eligibility',
      'registration',
      'verification',
      'timeline',
      'votingDay',
      'results'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.journeyTitle),
      ),
      body: Column(
        children: [
          // Progress header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: GlassDecoration.gradientCard(
              colors: [const Color(0xFFFF9933), const Color(0xFFFF6B00)],
            ),
            child: Column(
              children: [
                Text(
                  l10n.stepsCompleted(
                      session.completedSteps, session.totalSteps),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: session.progressPercent,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          // Steps list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final step = steps[index];
                final key = stepKeys[index];
                final isCompleted = session.progress[key] ?? false;
                final isExpanded = _expandedIndex == index;

                return _JourneyStepCard(
                  index: index,
                  title: step['title']!,
                  description: step['desc']!,
                  detailTitle: step['detailTitle']!,
                  detailBody: step['detailBody']!,
                  icon: step['icon'] as IconData,
                  isCompleted: isCompleted,
                  isExpanded: isExpanded,
                  isDark: isDark,
                  totalSteps: steps.length,
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? -1 : index;
                    });
                  },
                  onMarkComplete: () {
                    ref.read(sessionProvider.notifier).markStepComplete(key);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSteps(AppLocalizations l10n) {
    return [
      {
        'title': l10n.step1Eligibility,
        'desc': l10n.step1Desc,
        'detailTitle': l10n.step1DetailTitle,
        'detailBody': l10n.step1DetailBody,
        'icon': Icons.verified_user_rounded,
      },
      {
        'title': l10n.step2Registration,
        'desc': l10n.step2Desc,
        'detailTitle': l10n.step2DetailTitle,
        'detailBody': l10n.step2DetailBody,
        'icon': Icons.app_registration_rounded,
      },
      {
        'title': l10n.step3Verification,
        'desc': l10n.step3Desc,
        'detailTitle': l10n.step3DetailTitle,
        'detailBody': l10n.step3DetailBody,
        'icon': Icons.fact_check_rounded,
      },
      {
        'title': l10n.step4Timeline,
        'desc': l10n.step4Desc,
        'detailTitle': l10n.step4DetailTitle,
        'detailBody': l10n.step4DetailBody,
        'icon': Icons.calendar_month_rounded,
      },
      {
        'title': l10n.step5VotingDay,
        'desc': l10n.step5Desc,
        'detailTitle': l10n.step5DetailTitle,
        'detailBody': l10n.step5DetailBody,
        'icon': Icons.how_to_vote_rounded,
      },
      {
        'title': l10n.step6Results,
        'desc': l10n.step6Desc,
        'detailTitle': l10n.step6DetailTitle,
        'detailBody': l10n.step6DetailBody,
        'icon': Icons.emoji_events_rounded,
      },
    ];
  }
}

class _JourneyStepCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String detailTitle;
  final String detailBody;
  final IconData icon;
  final bool isCompleted;
  final bool isExpanded;
  final bool isDark;
  final int totalSteps;
  final VoidCallback onTap;
  final VoidCallback onMarkComplete;

  const _JourneyStepCard({
    required this.index,
    required this.title,
    required this.description,
    required this.detailTitle,
    required this.detailBody,
    required this.icon,
    required this.isCompleted,
    required this.isExpanded,
    required this.isDark,
    required this.totalSteps,
    required this.onTap,
    required this.onMarkComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stepColor = isCompleted
        ? const Color(0xFF138808)
        : theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF138808)
                        : isDark
                            ? AppTheme.darkCard
                            : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: stepColor,
                      width: 2,
                    ),
                  ),
                  child: Semantics(
                    label: isCompleted ? 'Step ${index + 1} completed' : 'Step ${index + 1} pending',
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 20)
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: stepColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
                if (index < totalSteps - 1)
                  Container(
                    width: 2,
                    height: isExpanded ? 300 : 60,
                    color: isCompleted
                        ? const Color(0xFF138808).withValues(alpha: 0.5)
                        : Colors.grey.withValues(alpha: 0.3),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Card content
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(icon, color: stepColor, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: isCompleted
                                          ? const Color(0xFF138808)
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    description,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                    maxLines: isExpanded ? null : 2,
                                    overflow: isExpanded
                                        ? null
                                        : TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.expand_less_rounded
                                  : Icons.expand_more_rounded,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ),
                      // Expanded content
                      if (isExpanded) ...[
                        Divider(
                          height: 1,
                          color: theme.dividerTheme.color,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detailTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 12),
                                Text(
                                  detailBody,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.6,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.8),
                                  ),
                                ),
                                if (index == 1) ...[
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Required Documents Checklist:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _DocumentItem(label: 'Proof of Age (Aadhaar, Birth Certificate)'),
                                  _DocumentItem(label: 'Proof of Residence (Electricity Bill, Passport)'),
                                  _DocumentItem(label: 'Passport size photograph'),
                                  _DocumentItem(label: 'Form 6 (Application for inclusion)'),
                                ],
                              const SizedBox(height: 16),
                              if (!isCompleted)
                                SizedBox(
                                  width: double.infinity,
                                  child: Semantics(
                                    label: 'Mark step ${index + 1} as complete',
                                    button: true,
                                    onTap: onMarkComplete,
                                    child: FilledButton.icon(
                                      onPressed: onMarkComplete,
                                      icon: const Icon(Icons.check_rounded),
                                      label: Text(
                                          AppLocalizations.of(context)!
                                              .markComplete),
                                      style: FilledButton.styleFrom(
                                        backgroundColor: const Color(0xFF138808),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF138808)
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF138808), size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        AppLocalizations.of(context)!.completed,
                                        style: const TextStyle(
                                          color: Color(0xFF138808),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentItem extends StatefulWidget {
  final String label;
  const _DocumentItem({required this.label});

  @override
  State<_DocumentItem> createState() => _DocumentItemState();
}

class _DocumentItemState extends State<_DocumentItem> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _checked = !_checked),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              _checked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
              color: _checked ? const Color(0xFF138808) : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  decoration: _checked ? TextDecoration.lineThrough : null,
                  color: _checked ? Colors.grey : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

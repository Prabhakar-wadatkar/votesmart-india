import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:votesmart_india/l10n/generated/app_localizations.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final l10n = AppLocalizations.of(context)!;
    final isDark = ref.watch(darkModeProvider);
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 800;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverToBoxAdapter(
            child: _buildHeroSection(context, l10n, isDark),
          ),
          // Stats Cards
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 32 : 16,
              vertical: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: _buildStatsSection(context, session, l10n, isDark, isWide),
            ),
          ),
          // Quick Actions
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 32 : 16),
            sliver: SliverToBoxAdapter(
              child: _buildQuickActions(context, l10n, isDark, isWide),
            ),
          ),
          // Recent Info
          SliverPadding(
            padding: EdgeInsets.all(isWide ? 32 : 16),
            sliver: SliverToBoxAdapter(
              child: _buildInfoCards(context, l10n, isDark, isWide),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Widget _buildHeroSection(
      BuildContext context, AppLocalizations l10n, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1A1A2E),
                  const Color(0xFF16213E),
                  const Color(0xFF0F3460),
                ]
              : [
                  const Color(0xFFFF9933),
                  const Color(0xFFFFAD60),
                  const Color(0xFFFFD699),
                ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Semantics(
                      label: 'Voting Icon',
                      child: Icon(
                        Icons.how_to_vote_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.welcomeMessage,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.welcomeSubtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Indian flag stripe
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(height: 4, color: const Color(0xFFFF9933))),
                    Expanded(
                        child: Container(height: 4, color: Colors.white)),
                    Expanded(
                        child: Container(height: 4, color: const Color(0xFF138808))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, dynamic session,
      AppLocalizations l10n, bool isDark, bool isWide) {
    final completedSteps = session.completedSteps as int;
    final totalSteps = session.totalSteps as int;
    final progressPercent = session.progressPercent as double;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cards = [
          _StatCard(
            icon: Icons.route_rounded,
            title: l10n.journeyProgress,
            value: '${(progressPercent * 100).toInt()}%',
            subtitle: l10n.stepsCompleted(completedSteps, totalSteps),
            gradient: [const Color(0xFFFF9933), const Color(0xFFFF6B00)],
            progress: progressPercent,
            isDark: isDark,
          ),
          _StatCard(
            icon: Icons.verified_user_rounded,
            title: l10n.eligibilityStatus,
            value: session.isEligible ? l10n.eligible : l10n.notEligible,
            subtitle: session.age != null
                ? '${l10n.age}: ${session.age}'
                : l10n.checkEligibility,
            gradient: session.isEligible
                ? [const Color(0xFF138808), const Color(0xFF4CAF50)]
                : [const Color(0xFF9E9E9E), const Color(0xFFBDBDBD)],
            isDark: isDark,
          ),
          _StatCard(
            icon: Icons.calendar_today_rounded,
            title: l10n.nextElection,
            value: 'Maharashtra',
            subtitle: 'Lok Sabha By-election 2026',
            gradient: [const Color(0xFF1C39BB), const Color(0xFF5C7CFA)],
            isDark: isDark,
          ),
        ];

        if (isWide) {
          return Row(
            children: cards
                .map((card) => Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: card,
                    )))
                .toList(),
          );
        }

        return Column(
          children: cards
              .map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: card,
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildQuickActions(
      BuildContext context, AppLocalizations l10n, bool isDark, bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _QuickActionChip(
              icon: Icons.chat_bubble_rounded,
              label: l10n.askAiAssistant,
              color: const Color(0xFFFF9933),
              onTap: () => context.go('/chat'),
            ),
            _QuickActionChip(
              icon: Icons.route_rounded,
              label: l10n.startJourney,
              color: const Color(0xFF138808),
              onTap: () => context.go('/journey'),
            ),
            _QuickActionChip(
              icon: Icons.calendar_month_rounded,
              label: l10n.viewTimeline,
              color: const Color(0xFF1C39BB),
              onTap: () => context.go('/timeline'),
            ),
            _QuickActionChip(
              icon: Icons.description_rounded,
              label: l10n.documentsTitle,
              color: const Color(0xFF9C27B0),
              onTap: () => context.go('/journey'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCards(
      BuildContext context, AppLocalizations l10n, bool isDark, bool isWide) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.recentChats,
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: GlassDecoration.glass(isDark: isDark),
          child: Column(
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.noChatsYet,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.go('/chat'),
                icon: const Icon(Icons.chat_rounded),
                label: Text(l10n.askAiAssistant),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Disclaimer
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded,
                  color: theme.colorScheme.tertiary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.poweredByAi,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final List<Color> gradient;
  final double? progress;
  final bool isDark;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.gradient,
    this.progress,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: GlassDecoration.gradientCard(colors: gradient),
      child: Semantics(
        label: '$title: $value. $subtitle',
        container: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            if (progress != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress!,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  minHeight: 6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Semantics(
        label: label,
        button: true,
        onTap: onTap,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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

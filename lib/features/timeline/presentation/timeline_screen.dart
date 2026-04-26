import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:votesmart_india/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/election_model.dart';
import '../data/election_data.dart';

final selectedRegionProvider = NotifierProvider<SelectedRegionNotifier, String>(() {
  return SelectedRegionNotifier();
});

class SelectedRegionNotifier extends Notifier<String> {
  @override
  String build() {
    return 'All';
  }

  void setRegion(String region) {
    state = region;
  }
}

class TimelineScreen extends ConsumerWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = ref.watch(darkModeProvider);
    final selectedRegion = ref.watch(selectedRegionProvider);
    final theme = Theme.of(context);
    final locale = ref.watch(localeProvider);

    final allElections = ElectionData.getMockElections();
    final elections = selectedRegion == 'All'
        ? allElections
        : allElections.where((e) => e.region == selectedRegion).toList();

    // Sort by polling date
    elections.sort((a, b) {
      final aDate = a.pollingDate ?? DateTime(2099);
      final bDate = b.pollingDate ?? DateTime(2099);
      return aDate.compareTo(bDate);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.timelineTitle),
      ),
      body: Column(
        children: [
          // Region filter
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterChip(
                    label: l10n.allRegions,
                    isSelected: selectedRegion == 'All',
                    onTap: () => ref.read(selectedRegionProvider.notifier).setRegion('All'),
                  ),
                  ...ElectionData.getRegions().map((region) => _FilterChip(
                        label: region,
                        isSelected: selectedRegion == region,
                        onTap: () => ref.read(selectedRegionProvider.notifier).setRegion(region),
                      )),
                ],
              ),
            ),
          ),
          // Timeline
          Expanded(
            child: elections.isEmpty
                ? Center(
                    child: Text(
                      'No elections found for this region',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: elections.length,
                    itemBuilder: (context, index) {
                      return _TimelineCard(
                        election: elections[index],
                        isLast: index == elections.length - 1,
                        isDark: isDark,
                        locale: locale.languageCode,
                        l10n: l10n,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Semantics(
        label: '$label filter',
        selected: isSelected,
        button: true,
        child: FilterChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (_) => onTap(),
          selectedColor: theme.colorScheme.primary.withValues(alpha: 0.2),
          checkmarkColor: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final ElectionModel election;
  final bool isLast;
  final bool isDark;
  final String locale;
  final AppLocalizations l10n;

  const _TimelineCard({
    required this.election,
    required this.isLast,
    required this.isDark,
    required this.locale,
    required this.l10n,
  });

  Color get _typeColor {
    switch (election.type) {
      case 'general':
        return const Color(0xFFFF9933);
      case 'state':
        return const Color(0xFF1C39BB);
      case 'local':
        return const Color(0xFF138808);
      default:
        return Colors.grey;
    }
  }

  String get _typeName {
    switch (election.type) {
      case 'general':
        return l10n.general;
      case 'state':
        return l10n.state;
      case 'local':
        return l10n.local;
      default:
        return election.type;
    }
  }

  String get _electionName {
    switch (locale) {
      case 'hi':
        return election.nameHi.isNotEmpty ? election.nameHi : election.name;
      case 'mr':
        return election.nameMr.isNotEmpty ? election.nameMr : election.name;
      default:
        return election.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd MMM yyyy');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line
        ExcludeSemantics(
          child: SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _typeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _typeColor.withValues(alpha: 0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _typeColor,
                          _typeColor.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Card
        Expanded(
          child: Semantics(
            label: '$_typeName Election: $_electionName. Region: ${election.region}. Polling Date: ${election.pollingDate != null ? dateFormat.format(election.pollingDate!) : "TBA"}',
            container: true,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: GlassDecoration.glass(isDark: isDark),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _typeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _typeName,
                          style: TextStyle(
                            color: _typeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (election.state != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            election.state!,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          l10n.upcoming,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _electionName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Date rows
                  if (election.nominationDate != null)
                    _DateRow(
                      icon: Icons.edit_document,
                      label: l10n.nominationDate,
                      date: dateFormat.format(election.nominationDate!),
                      color: Colors.orange,
                    ),
                  if (election.pollingDate != null) ...[
                    const SizedBox(height: 6),
                    _DateRow(
                      icon: Icons.how_to_vote_rounded,
                      label: l10n.pollingDate,
                      date: dateFormat.format(election.pollingDate!),
                      color: const Color(0xFF138808),
                    ),
                  ],
                  if (election.resultDate != null) ...[
                    const SizedBox(height: 6),
                    _DateRow(
                      icon: Icons.emoji_events_rounded,
                      label: l10n.resultDate,
                      date: dateFormat.format(election.resultDate!),
                      color: const Color(0xFF1C39BB),
                    ),
                  ],
                  // Metadata
                  if (election.metadata.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: election.metadata.entries
                          .map((e) => Chip(
                                label: Text(
                                  '${e.key}: ${e.value}',
                                  style: const TextStyle(fontSize: 11),
                                ),
                                visualDensity: VisualDensity.compact,
                              ))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String date;
  final Color color;

  const _DateRow({
    required this.icon,
    required this.label,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const Spacer(),
        Text(
          date,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class GlassDecoration {
  static BoxDecoration glass({required bool isDark}) {
    return BoxDecoration(
      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.2),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

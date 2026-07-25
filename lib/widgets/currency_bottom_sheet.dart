import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/app_localizations.dart';
import '../models/app_currency.dart';
import '../providers/currency_provider.dart';

class CurrencyBottomSheet extends ConsumerStatefulWidget {
  const CurrencyBottomSheet({super.key});

  @override
  ConsumerState<CurrencyBottomSheet> createState() =>
      _CurrencyBottomSheetState();
}

class _CurrencyBottomSheetState extends ConsumerState<CurrencyBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final AppCurrency current = ref.watch(currencyProvider);
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double maxHeight = MediaQuery.sizeOf(context).height * 0.75;

    final List<AppCurrency> filtered = AppCurrency.all
        .where((currency) => currency.matchesQuery(_query))
        .toList();

    // Color the sheet first, then SafeArea-pad content — otherwise the home
    // indicator inset stays transparent over the modal scrim.
    return Material(
      color: scheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.15,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.currencySelectionPrompt,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: l10n.currencySearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            l10n.currencySearchEmpty,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        )
                      : ListView.separated(
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) => Divider(
                            height: 1,
                            color: scheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                          itemBuilder: (context, index) {
                            final AppCurrency currency = filtered[index];
                            final bool isSelected =
                                currency.code == current.code;

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: isSelected
                                    ? scheme.primary
                                    : scheme.surfaceContainerHighest,
                                foregroundColor: isSelected
                                    ? scheme.onPrimary
                                    : scheme.onSurface,
                                child: Text(
                                  currency.symbol.trim(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              title: Text(
                                currency.code,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(currency.name),
                              trailing: isSelected
                                  ? Icon(
                                      Icons.check_circle,
                                      color: scheme.primary,
                                    )
                                  : null,
                              onTap: () async {
                                await ref
                                    .read(currencyProvider.notifier)
                                    .setCurrency(currency);
                                await Future.delayed(
                                  const Duration(milliseconds: 150),
                                );
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                            );
                          },
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

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../viewmodels/details_viewmodel.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../widgets/stat_card.dart';
import '../widgets/character_distribution_chart.dart';

class DetailsScreen extends StatefulWidget {
  final List<GridItem> items;
  final int gridColumns;

  const DetailsScreen({
    super.key,
    required this.items,
    required this.gridColumns,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final DetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = DetailsViewModel(
      items: widget.items,
      gridColumns: widget.gridColumns,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.details),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    StatCard(
                      title: l10n.gridColumns,
                      value: '${_viewModel.gridColumns}',
                      icon: Icons.view_column,
                      color: Colors.blue,
                    ),
                    StatCard(
                      title: l10n.totalRows,
                      value: '${(_viewModel.items.length / _viewModel.gridColumns).ceil()}',
                      icon: Icons.grid_on,
                      color: Colors.green,
                    ),
                    StatCard(
                      title: l10n.editsPerformed,
                      value: '${_viewModel.totalEditCount}',
                      icon: Icons.edit,
                      color: Colors.orange,
                    ),
                    StatCard(
                      title: l10n.totalCharacters,
                      value: '${_viewModel.totalCharacters}',
                      icon: Icons.text_fields,
                      color: Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                CharacterDistributionChart(
                  letterCount: _viewModel.letterCount,
                  numberCount: _viewModel.numberCount,
                ),
                const SizedBox(height: 24),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.itemDetails,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 16),
                        ..._viewModel.items.map((item) => _buildItemDetail(context, item)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemDetail(BuildContext context, GridItem item) {
    final l10n = AppLocalizations.of(context)!;
    final charCount = item.name.length + item.description.length;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            item.icon,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (item.description.isNotEmpty)
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$charCount ${l10n.characters}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

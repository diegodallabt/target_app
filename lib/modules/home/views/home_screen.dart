import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:target_app/l10n/app_localizations.dart';
import '../../../core/stores/theme/theme_store.dart';
import '../../../core/stores/translate/locale_store.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/language_selector.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/grid_item_card.dart';
import '../../login/services/auth_service.dart';
import '../../login/services/preferences_service.dart';
import '../../../core/errors/preferences_exception.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = HomeViewModel();
  final _textController = TextEditingController();
  final _authService = AuthService();
  final _preferencesService = PreferencesService();
  String? _openCardId;
  int _gridColumns = 3;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        final themeStore = Modular.get<ThemeStore>();
        final localeStore = Modular.get<LocaleStore>();

        await Future.wait([
          themeStore.loadTheme(user.id),
          localeStore.loadLocale(user.id),
          viewModel.loadItems(user.id),
        ]);

        final preferences = await _preferencesService.loadPreferences(user.id);
        setState(() {
          _gridColumns = preferences.gridColumns;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } on PreferencesException catch (e) {
      if (mounted) {
        _showErrorSnackBar(e.message);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Erro ao carregar preferências do usuário');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveGridColumns(int columns) async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        await _preferencesService.updateGridColumns(user.id, columns);
      }
    } on PreferencesException catch (e) {
      if (mounted) {
        _showErrorSnackBar(e.message);
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Erro ao salvar preferências de layout');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeStore = Modular.get<ThemeStore>();
    final localeStore = Modular.get<LocaleStore>();
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: Icon(
                themeStore.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () => themeStore.toggleTheme(),
              tooltip: themeStore.isDarkMode ? l10n.lightMode : l10n.darkMode,
            ),
          ),
          LanguageSelector(localeStore: localeStore),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Modular.to.navigate('/');
            },
            tooltip: l10n.logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerRight,
            child: _LayoutSelector(
              selectedColumns: _gridColumns,
              onChanged: (columns) {
                setState(() {
                  _gridColumns = columns;
                  _openCardId = null;
                });
                _saveGridColumns(columns);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Observer(
                      builder: (_) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: viewModel.items.isEmpty
                              ? Center(
                                  key: const ValueKey('empty'),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.inbox,
                                        size: 80,
                                        color: Colors.grey.withAlpha(100),
                                      ),
                                      Text(
                                        l10n.noItemsYet,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  key: ValueKey('grid-$_gridColumns'),
                                  addAutomaticKeepAlives: false,
                                  addRepaintBoundaries: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: _gridColumns,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: _gridColumns == 1 ? 1.2 : 1,
                                      ),
                                  itemCount: viewModel.items.length,
                                  itemBuilder: (context, index) {
                                    final item = viewModel.items[index];
                                    return RepaintBoundary(
                                      child: GridItemCard(
                                      key: ValueKey(item.id),
                                      item: item,
                                      gridColumns: _gridColumns,
                                      isOpen: _openCardId == item.id,
                                      onToggle: () => setState(() {
                                        _openCardId = _openCardId == item.id
                                            ? null
                                            : item.id;
                                      }),
                                      onRemove: () =>
                                          viewModel.removeItem(item.id),
                                      onEdit:
                                          (newName, newDescription, newIcon) =>
                                              viewModel.editItem(
                                                item.id,
                                                newName,
                                                newDescription: newDescription,
                                                newIcon: newIcon,
                                              ),
                                      ),
                                    );
                                  },
                                ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Observer(
                    builder: (_) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: l10n.newItem,
                            prefixIcon: Icons.add_circle_outline,
                            controller: _textController,
                            onChanged: viewModel.setNewItemName,
                            errorText: viewModel.errorMessage != null
                                ? l10n.itemNameEmpty
                                : null,
                            onSubmitted: (_) {
                              viewModel.addItem();
                              _textController.clear();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          child: PrimaryButton(
                            text: l10n.add,
                            onPressed: () {
                              viewModel.addItem();
                              _textController.clear();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LayoutSelector extends StatelessWidget {
  final int selectedColumns;
  final ValueChanged<int> onChanged;

  const _LayoutSelector({
    required this.selectedColumns,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(
          (0.5 * 255).round(),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LayoutButton(
            icon: Icons.view_agenda_rounded,
            isSelected: selectedColumns == 1,
            onTap: () => onChanged(1),
            tooltip: 'Lista',
          ),
          _LayoutButton(
            icon: Icons.grid_view_rounded,
            isSelected: selectedColumns == 2,
            onTap: () => onChanged(2),
            tooltip: 'Grid 2 colunas',
          ),
          _LayoutButton(
            icon: Icons.apps_rounded,
            isSelected: selectedColumns == 3,
            onTap: () => onChanged(3),
            tooltip: 'Grid 3 colunas',
          ),
        ],
      ),
    );
  }
}

class _LayoutButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String tooltip;

  const _LayoutButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary.withAlpha((0.2 * 255).round())
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

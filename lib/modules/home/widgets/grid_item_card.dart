import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:target_app/l10n/app_localizations.dart';
import '../viewmodels/home_viewmodel.dart';
import 'edit_item_dialog.dart';
import 'delete_item_dialog.dart';
import 'action_button.dart';

class GridItemCard extends StatefulWidget {
  final GridItem item;
  final int gridColumns;
  final bool isOpen;
  final VoidCallback onToggle;
  final VoidCallback onRemove;
  final Function(String, String, IconData) onEdit;

  const GridItemCard({
    super.key,
    required this.item,
    required this.gridColumns,
    required this.isOpen,
    required this.onToggle,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  State<GridItemCard> createState() => _GridItemCardState();
}

class _GridItemCardState extends State<GridItemCard>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late AnimationController _removeController;
  late Animation<double> _flipAnimation;
  late Animation<double> _removeScaleAnimation;
  late Animation<double> _removeFadeAnimation;
  late Animation<double> _removeRotationAnimation;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _removeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );

    _removeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.2,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInBack)),
        weight: 70.0,
      ),
    ]).animate(_removeController);

    _removeFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _removeController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _removeRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_removeController);
  }

  @override
  void didUpdateWidget(GridItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    _removeController.dispose();
    super.dispose();
  }

  Future<void> _animateRemoval() async {
    setState(() {
      _isRemoving = true;
    });
    await _removeController.forward();
    widget.onRemove();
  }

  void _toggleView() {
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _removeController,
      builder: (context, child) {
        return Transform.scale(
          scale: _isRemoving ? _removeScaleAnimation.value : 1.0,
          child: Transform.rotate(
            angle: _isRemoving ? _removeRotationAnimation.value : 0.0,
            child: Opacity(
              opacity: _isRemoving ? _removeFadeAnimation.value : 1.0,
              child: child!,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _toggleView,
          child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, child) {
              final angle = _flipAnimation.value * math.pi;
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle);

              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: angle < math.pi / 2
                    ? _buildDefaultView(context)
                    : Transform(
                        transform: Matrix4.identity()..rotateY(math.pi),
                        alignment: Alignment.center,
                        child: _buildActionsView(context, l10n),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultView(BuildContext context) {
    final iconSize = widget.gridColumns == 1
        ? 120.0
        : widget.gridColumns == 2
        ? 80.0
        : 56.0;

    final fontSize = widget.gridColumns == 1
        ? 18.0
        : widget.gridColumns == 2
        ? 15.0
        : 13.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          widget.item.icon,
          size: iconSize,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.item.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: fontSize),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsView(BuildContext context, AppLocalizations l10n) {
    final actionIconSize = widget.gridColumns == 1
        ? 56.0
        : widget.gridColumns == 2
        ? 42.0
        : 32.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              icon: Icons.edit,
              color: Colors.green,
              size: actionIconSize,
              onTap: () {
                _toggleView();
                Future.delayed(const Duration(milliseconds: 600), () {
                  _showEditDialog(context, l10n);
                });
              },
            ),
            const SizedBox(width: 6),
            ActionButton(
              icon: Icons.delete,
              color: Colors.red,
              size: actionIconSize,
              onTap: () {
                _toggleView();
                Future.delayed(const Duration(milliseconds: 600), () {
                  _showDeleteDialog(context, l10n);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) =>
          EditItemDialog(item: widget.item, l10n: l10n, onEdit: widget.onEdit),
    );
  }

  void _showDeleteDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => DeleteItemDialog(
        itemName: widget.item.name,
        l10n: l10n,
        onDelete: _animateRemoval,
      ),
    );
  }
}

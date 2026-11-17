import 'package:material_ui/material_ui.dart';

/// Shown instead of tiles: no matches, nothing that can be shown, or a
/// load that failed. Each says what happened and has one button forward.
class GalleryMessage extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String body;
  final String actionLabel;
  final VoidCallback onAction;

  const GalleryMessage({
    super.key,
    required this.icon,
    this.title,
    required this.body,
    required this.actionLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heading = title;

    return Padding(
      // 16 at the sides on top of the grid's own inset, which this sits
      // inside.
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48.0, color: theme.colorScheme.outline),
              const SizedBox(height: 16.0),
              if (heading != null) ...[
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8.0),
              ],
              Text(
                body,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                onPressed: onAction,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(64.0, 48.0),
                ),
                child: Text(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

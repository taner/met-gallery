import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

import '../../../strings.dart';

/// How long a load may run before the gallery says why.
const Duration kSlowLoadAfter = Duration(seconds: 4);

/// A line that appears under a load that has run long, and takes no space
/// until then. Driven by elapsed time, so it covers both the app's own
/// request pacing and a slow network.
class SlowLoadNote extends HookWidget {
  final bool loading;

  const SlowLoadNote({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    // True once the load has run, without a break, for [kSlowLoadAfter].
    final slow = useState(false);
    useEffect(() {
      if (!loading) {
        slow.value = false;
        return null;
      }
      final timer = Timer(kSlowLoadAfter, () => slow.value = true);
      return timer.cancel;
    }, [loading]);

    if (!loading || !slow.value) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Text(
      Strings.slowLoad,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

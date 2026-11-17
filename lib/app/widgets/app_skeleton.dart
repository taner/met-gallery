import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Draws [child] as a skeleton, using the skeletonizer package: its text
/// as bars, its `Bone`s as blocks, with a slow shimmer across them.
///
/// The colours come from the theme. With animations disabled, the
/// skeleton is one flat colour with no shimmer.
class AppSkeleton extends StatelessWidget {
  final Widget child;

  const AppSkeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHighest;

    return Skeletonizer(
      effect: MediaQuery.disableAnimationsOf(context)
          ? SolidColorEffect(color: base)
          : ShimmerEffect(
              baseColor: base,
              highlightColor: scheme.surfaceContainerLow,
              duration: const Duration(milliseconds: 1600),
            ),
      child: child,
    );
  }
}

import 'package:material_ui/material_ui.dart';

import 'widgets/gallery_module.dart';

/// The widest the gallery's content may grow.
const double _kMaxContentWidth = 1120.0;

/// The home screen: a frame for its one module, [GalleryModule].
class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The module gets the full width, so that its scrollbar is at the edge
    // of the window.
    return const Scaffold(
      body: SafeArea(child: GalleryModule(maxContentWidth: _kMaxContentWidth)),
    );
  }
}

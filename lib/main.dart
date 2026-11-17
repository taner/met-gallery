import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';
import 'env.dart';

Future<void> main() async {
  // Before the first frame, because the HTTP client reads its base URL
  // from here. It cannot fail.
  await Env.load();

  runApp(const ProviderScope(child: App()));
}

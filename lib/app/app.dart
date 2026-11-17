import 'package:material_ui/material_ui.dart';

import 'app_theme.dart';
import 'modules/gallery/gallery_page.dart';
import 'strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      darkTheme: appThemeDark,
      // Follows the system; there is no toggle.
      themeMode: ThemeMode.system,
      home: const GalleryPage(),
    );
  }
}

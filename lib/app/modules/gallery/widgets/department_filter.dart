import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/models/department.dart';
import '../../../strings.dart';

/// Narrows the search to one of the museum's departments.
///
/// While the list loads the menu is disabled and reads "All departments";
/// if it fails, a retry takes the menu's place.
class DepartmentFilter extends StatelessWidget {
  final AsyncValue<List<Department>> departments;

  /// The department the gallery is narrowed to; null for all of them.
  final Department? selected;
  final ValueChanged<Department?> onSelected;
  final VoidCallback onRetry;

  const DepartmentFilter({
    super.key,
    required this.departments,
    required this.selected,
    required this.onSelected,
    required this.onRetry,
  });

  /// The menu's value for "All departments". Real ids start at 1.
  static const int _all = 0;

  @override
  Widget build(BuildContext context) {
    if (departments.hasError && !departments.isLoading) {
      return Tooltip(
        message: Strings.departmentsFailed,
        child: OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text(Strings.retryDepartments),
          style: OutlinedButton.styleFrom(
            // The search field's height and corners, so the row does not
            // change shape between this and the menu.
            minimumSize: const Size.fromHeight(56.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
        ),
      );
    }

    final options = departments.value ?? const <Department>[];

    return DropdownMenu<int>(
      enabled: departments.hasValue,
      // Fill the width the search area gives it.
      expandedInsets: EdgeInsets.zero,
      // A list to pick from, not a field to type in.
      requestFocusOnTap: false,
      menuHeight: 320.0,
      // Marks the entry whose label is the field's text exactly; the
      // default matches the first label containing it.
      searchCallback: (entries, query) {
        final index = entries.indexWhere((entry) => entry.label == query);
        return index == -1 ? null : index;
      },
      initialSelection: selected?.departmentId ?? _all,
      dropdownMenuEntries: [
        const DropdownMenuEntry(value: _all, label: Strings.allDepartments),
        for (final department in options)
          DropdownMenuEntry(
            value: department.departmentId,
            label: department.displayName,
          ),
      ],
      onSelected: (id) {
        final chosen = options
            .where((department) => department.departmentId == id)
            .firstOrNull;
        onSelected(chosen);
      },
    );
  }
}

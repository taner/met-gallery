import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/models/department.dart';
import '../../../strings.dart';
import '../gallery_helper.dart';
import 'department_filter.dart';

/// How long typing must pause before it counts as a search.
const Duration kSearchDebounce = Duration(milliseconds: 450);

/// The search field, the department filter beside it and the starting
/// points under them.
///
/// Typing (debounced), Enter and a chip all end in [onSearch]; the notifier
/// ignores a search for what is already on screen. A chip is a toggle: a
/// second click lets it go, which empties the field.
///
/// What the reader types is remembered ([onRemember]) and offered again in
/// a list under the field ([history]).
class GallerySearch extends HookWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  final AsyncValue<List<Department>> departments;

  /// The department the gallery is narrowed to; null for all of them.
  final Department? department;
  final ValueChanged<Department?> onDepartment;
  final VoidCallback onRetryDepartments;

  /// Earlier typed searches, newest first.
  final List<String> history;
  final ValueChanged<String> onRemember;
  final ValueChanged<String> onForget;

  const GallerySearch({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.departments,
    required this.department,
    required this.onDepartment,
    required this.onRetryDepartments,
    required this.history,
    required this.onRemember,
    required this.onForget,
  });

  @override
  Widget build(BuildContext context) {
    final text = useValueListenable(controller).text;
    final focusNode = useFocusNode();

    // The text as the reader last typed it. Chips, the clear button and
    // other ways of setting the field are not remembered in the history.
    final lastTyped = useRef<String?>(null);

    // Whether the reader has moved through the history list with the
    // arrow keys since they last typed. It decides what Enter means.
    final pickingWithArrows = useValueNotifier(false);

    // Holds the text back until it has stopped changing for
    // [kSearchDebounce], so a typed word is one search.
    final settledText = useDebounced(text, kSearchDebounce);

    useEffect(() {
      if (settledText == null) return null;

      // A search changes provider state, which a build may not do, so it
      // runs in a microtask.
      scheduleMicrotask(() {
        if (!context.mounted) return;
        onSearch(settledText);
        if (settledText == lastTyped.value &&
            isWorthRemembering(settledText, submitted: false)) {
          onRemember(settledText);
        }
      });
      return null;
    }, [settledText]);

    final field = RawAutocomplete<String>(
      textEditingController: controller,
      focusNode: focusNode,
      optionsBuilder: (value) => searchSuggestions(history, value.text),
      onSelected: (query) {
        // The autocomplete has already put the entry in the field.
        pickingWithArrows.value = false;
        onRemember(query);
        onSearch(query);
      },
      optionsViewBuilder: (context, onSelected, options) => _HistoryList(
        // An entry removed since the options were worked out is left out.
        entries: [
          for (final entry in options)
            if (history.contains(entry)) entry,
        ],
        picking: pickingWithArrows,
        onSelected: onSelected,
        onForget: onForget,
      ),
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return Focus(
          // Only watching: the autocomplete above moves the highlight.
          canRequestFocus: false,
          skipTraversal: true,
          onKeyEvent: (_, event) {
            final arrow =
                event.logicalKey == LogicalKeyboardKey.arrowDown ||
                event.logicalKey == LogicalKeyboardKey.arrowUp;
            if (arrow && event is KeyDownEvent) pickingWithArrows.value = true;
            return KeyEventResult.ignored;
          },
          child: TextField(
            // Named, because the department menu beside it is a text
            // field too as far as a finder is concerned.
            key: const Key('gallery_search_field'),
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            autocorrect: false,
            onChanged: (typed) {
              lastTyped.value = typed;
              pickingWithArrows.value = false;
            },
            onSubmitted: (typed) {
              // Enter searches for what was typed, unless the reader moved
              // to an entry with the arrow keys.
              if (pickingWithArrows.value) return onFieldSubmitted();

              onSearch(typed);
              onRemember(typed);
              // Out of the field, so the list closes over the results.
              focusNode.unfocus();
            },
            decoration: InputDecoration(
              hintText: Strings.searchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: Strings.clearSearch,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        controller.clear();
                        // At once, without waiting for the debounce.
                        onSearch('');
                      },
                    ),
            ),
          ),
        );
      },
    );

    final filter = DepartmentFilter(
      departments: departments,
      selected: department,
      onSelected: onDepartment,
      onRetry: onRetryDepartments,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < kFilterBesideSearchFrom) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [field, const SizedBox(height: 8.0), filter],
              );
            }
            return Row(
              children: [
                Expanded(child: field),
                const SizedBox(width: 12.0),
                SizedBox(width: kDepartmentFilterWidth, child: filter),
              ],
            );
          },
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: [
            for (final point in kStartingPoints)
              ChoiceChip(
                label: Text(point),
                selected: isStartingPointChosen(point, fieldText: text),
                onSelected: (chosen) {
                  // The field shows what the gallery shows; letting a chip
                  // go empties it.
                  controller.text = chosen ? point : '';
                  onSearch(controller.text);
                },
              ),
          ],
        ),
      ],
    );
  }
}

/// The history, as a list hanging from the search field: one row per
/// earlier search, each with a button that removes it.
///
/// Clicking a row searches for it again. A row is tinted only once the
/// reader has used the arrow keys ([picking]).
class _HistoryList extends StatelessWidget {
  final List<String> entries;
  final ValueNotifier<bool> picking;
  final ValueChanged<String> onSelected;
  final ValueChanged<String> onForget;

  const _HistoryList({
    required this.entries,
    required this.picking,
    required this.onSelected,
    required this.onForget,
  });

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final row = AutocompleteHighlightedOption.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Material(
        elevation: 3.0,
        color: scheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          // Five rows, then it scrolls.
          constraints: const BoxConstraints(maxHeight: 240.0),
          child: ValueListenableBuilder<bool>(
            valueListenable: picking,
            builder: (context, isPicking, _) => ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return InkWell(
                  key: Key('search_history_$entry'),
                  onTap: () => onSelected(entry),
                  child: ColoredBox(
                    color: isPicking && index == row
                        ? scheme.onSurface.withValues(alpha: 0.08)
                        : Colors.transparent,
                    child: SizedBox(
                      height: 48.0,
                      child: Row(
                        children: [
                          const SizedBox(width: 12.0),
                          Icon(
                            Icons.history,
                            size: 20.0,
                            color: scheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              entry,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          IconButton(
                            tooltip: Strings.forgetSearch(entry),
                            icon: const Icon(Icons.close, size: 18.0),
                            onPressed: () => onForget(entry),
                          ),
                          const SizedBox(width: 4.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

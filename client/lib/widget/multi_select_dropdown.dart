import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedItems = [];

  String get dropdownText {
    if (selectedItems.isEmpty) {
      return 'Select Brands';
    }

    return selectedItems.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,

            hint: Text(
              dropdownText,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),

            items: widget.items.map((item) {
              return DropdownItem<String>(
                value: item,
                height: 40,
                closeOnTap: false,

                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selectedItems.contains(item);

                    return InkWell(
                      onTap: () {
                        if (isSelected) {
                          selectedItems.remove(item);
                        } else {
                          selectedItems.add(item);
                        }

                        setState(() {});
                        menuSetState(() {});

                        widget.onSelectionChanged(selectedItems);
                      },

                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),

                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),

            onChanged: (value) {},

            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(left: 16, right: 8),
              height: 40,
              width: 180,
            ),

            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
    );
  }
}

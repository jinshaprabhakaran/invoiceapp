import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:invoice/global/constants/styles/colors.dart';

class CommonDropdown extends StatelessWidget {
  
  final List<String> items; // List of items for the dropdown
  final String selectedItem; // The currently selected item
  final ValueChanged<String?> onChanged; // Callback to handle item selection

  const CommonDropdown({
    Key? key,
    
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(isDense: false,
      value: selectedItem,
      underline: const Divider(color: kWhite,),
      elevation: 0,
      icon: const Icon(Icons.arrow_drop_down,color: kGrey,),
      isExpanded: false,
      onChanged: onChanged, // Pass the onChanged callback
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: KStyles().semiBold15(text:value,color: kBlack),
        );
      }).toList(),
    );
  }
}

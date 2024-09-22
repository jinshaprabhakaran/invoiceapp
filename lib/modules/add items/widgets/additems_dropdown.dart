import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';

import '../../../global/constants/styles/colors.dart';

class AdditemsDropdown extends StatelessWidget {
   final List<String> items; 
  final String selectedItem; 
  final ValueChanged<String?> onChanged;
final String hint;
  const AdditemsDropdown({ super.key,
    
    required this.items,
    required this.selectedItem,
    required this.onChanged,required this.hint
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
       hint: KStyles().med14(text: hint,color: kGrey),
      isDense: true,
      value: selectedItem,
      elevation: 0,
      icon: const Icon(Icons.arrow_drop_down,color: kGrey,),
      isExpanded: false,
      onChanged: onChanged, 
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(alignment: AlignmentDirectional.topStart,
          value: value,
          child: KStyles().med15(text:value,color: kBlack),
        );
      }).toList(),
    
       decoration: InputDecoration(fillColor: kWhite,filled: true,contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
         
          border: OutlineInputBorder( 
            borderSide:  const BorderSide(color:kGrey), 
            borderRadius: BorderRadius.circular(5), 
          ),
          enabledBorder: OutlineInputBorder(
           borderSide:  const BorderSide(color:kGrey), 
            borderRadius: BorderRadius.circular(5), 
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kBlue), // Adjust color as needed
            borderRadius: BorderRadius.circular(5), 
          ),
         )
    );
  }
}
import 'package:budget_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key, required this.categories});
  final List<String> categories;

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? _selectedCategory; // Store the selected category

  // List of categories (replace this with your own categories)
  List<String> categories = [];


  @override
  void initState() {
    super.initState();
    categories = widget.categories;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.black87,
      style: GoogleFonts.acme(color: Colors.white,),
      value: _selectedCategory,
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: SizedBox( width: MediaQuery.of(context).size.width*0.8,child: Text(category, style: GoogleFonts.acme(),)),
        );
      }).toList(),
      onChanged: (selectedCategory) {
        setState(() {
          _selectedCategory = selectedCategory;
          categoryValueNotifier.value = _selectedCategory;
        });
      },
      hint: Text('Select a category', style: GoogleFonts.acme(color: Colors.white,),),
    );
  }
}
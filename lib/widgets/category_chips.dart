import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';



class CategoryChips extends StatefulWidget {
  const CategoryChips({Key? key}) : super(key: key);


  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String selectedCategory = "Bills";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal, // Make it horizontal
      itemCount: filterOptions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: FilterChip(
              selectedColor: Colors.purple,
              backgroundColor: Colors.white70,
              label: Text(filterOptions[index], style: GoogleFonts.acme(color: Colors.black87),),
              onSelected:(bool value){
                if(value){
                  setState(() {
                      selectedCategory = filterOptions[index];
                  });
                  sortValueNotifierInHomeScreen.value = selectedCategory;
                }
              },
              selected: selectedCategory == filterOptions[index], // Set to true if you want some chips to be initially selected
            ),
          ),
        );
      },
    );
  }
}


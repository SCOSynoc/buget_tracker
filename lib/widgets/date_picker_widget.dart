import 'package:budget_tracker/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
   DateTime? _selectedDate;

  // Function to show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(Duration(days: 365)), // Allow selecting dates up to one year in the future
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateValueNotifier.value = "${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.calendar_today, color: Colors.white70,),
            SizedBox(width: 12.0),
            Text(
              _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate ?? DateTime.now())
                  : 'Select a date', style: GoogleFonts.acme(color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}

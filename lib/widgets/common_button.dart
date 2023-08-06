import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/dashboard_screen.dart';
import '../utils/utils.dart';

class CommonElevatedButton extends StatefulWidget {
  const CommonElevatedButton({Key? key, this.onPressed, required this.text}) : super(key: key);
  final Function()? onPressed;
  final String text;
  @override
  State<CommonElevatedButton> createState() => _CommonElevatedButtonState();
}

class _CommonElevatedButtonState extends State<CommonElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: loaderNotifier,
      builder: (BuildContext context, value, Widget? child) {
        return  ElevatedButton(
          onPressed:loaderNotifier.value ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.purple.shade700,
            onPrimary: Colors.white70,
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: GoogleFonts.acme(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child:loaderNotifier.value? const Center(child: CircularProgressIndicator( color: Colors.white70,)): Text(widget.text, style: GoogleFonts.acme(),),
        );
      },
    );
  }
}

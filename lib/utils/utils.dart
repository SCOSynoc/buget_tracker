import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void navigateToScreen(BuildContext context, Widget screen, {bool replace = false}) {
  if (replace) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}


void navigateAndRemovePush(BuildContext context, Widget screen,){
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => screen),
        (Route<dynamic> route) => route.isFirst
  );
}

ValueNotifier categoryValueNotifier = ValueNotifier("");
ValueNotifier sortValueNotifierInHomeScreen = ValueNotifier("Bills");
ValueNotifier amountValueNotifier = ValueNotifier(0.0);
ValueNotifier incomeValueNotifier = ValueNotifier(0.0);
ValueNotifier dateValueNotifier = ValueNotifier("");
ValueNotifier expenseListValueNotifier = ValueNotifier([]);
ValueNotifier incomeListValueNotifier = ValueNotifier([]);
ValueNotifier loaderNotifier = ValueNotifier(false);

List<String> filterOptions =[
  'Bills',
  'Travels',
  'Personal',
  'Food',
  "Festivals",
  "Entertainment",
  "Fun",
];


Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}


void showToast(String message){
  loaderNotifier.value = false;
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
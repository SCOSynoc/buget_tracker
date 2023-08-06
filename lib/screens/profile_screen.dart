import 'package:budget_tracker/features/auth/auth_controller.dart';
import 'package:budget_tracker/utils/utils.dart';
import 'package:budget_tracker/widgets/common_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String name = "";
    String mobileNum = "";
    String email = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: ref.read(authControllerProvider).getCurrentUserAuthData(),
          builder: (context, snapshot) {
            final data = snapshot.data ?? {} ;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${data["name"] ?? ""}',
                  style: GoogleFonts.acme(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Mobile Number: ${data["mobile_num"]}',
                  style: GoogleFonts.acme(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: ${data["email"]}',
                  style: GoogleFonts.acme(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Monthly Budget: ${data["monthly_budget"]}',
                  style: GoogleFonts.acme(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Annual Budget: ${data["annual_budget"]}',
                  style: GoogleFonts.acme(fontSize: 16),
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: CommonElevatedButton(text: "sign out", onPressed: (){
                      ref.read(authControllerProvider).signOutUser(context);
                  },),
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: CommonElevatedButton(text: "Export Expense report", onPressed: (){
                          _createPDF();
                  },),
                ),
                SizedBox(height: 18),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: CommonElevatedButton(text: "Export Income report", onPressed: (){
                    _createIncomePDF();
                  },),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 2, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Expense';
    header.cells[1].value = 'Category';
    header.cells[2].value = 'Date';

    PdfGridRow row1 = grid.rows.add();
    List<dynamic> expList = expenseListValueNotifier.value;
    for(int i =0 ; i< expList.length ; i++ ){
      row1 = grid.rows.add();
      row1.cells[0].value = "${expList[i]["expense"]}";
      row1.cells[1].value = "${expList[i]["category"]}";
      row1.cells[2].value = "${expList[i]["date"]}";
    }

    /*grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header2 = grid.headers[0];
    header2.cells[0].value = 'Expense';
    header2.cells[1].value = 'Category';
    header2.cells[2].value = 'Date';*/

    /*PdfGridRow row2= grid.rows.add();
    List<dynamic> incList = incomeListValueNotifier.value;
    for(int i =0 ; i< incList.length ; i++ ){
      row.cells[3].value = "${incList[i]["income"]}";
      row.cells[4].value = "${incList[i]["category"]}";
      row.cells[5].value = "${incList[i]["date"]}";
    }
*/

   /* row = grid.rows.add();
    row.cells[0].value = '2';
    row.cells[1].value = 'John';
    row.cells[2].value = '9';

    row = grid.rows.add();
    row.cells[0].value = '3';
    row.cells[1].value = 'Tony';
    row.cells[2].value = '8';*/

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(10, 10, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  Future<void> _createIncomePDF() async {

    PdfDocument document = PdfDocument();

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 2, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header2 = grid.headers[0];
    header2.cells[0].value = 'Income';
    header2.cells[1].value = 'Category';
    header2.cells[2].value = 'Date';

    PdfGridRow row= grid.rows.add();
    List<dynamic> incList = incomeListValueNotifier.value;
    for(int i =0 ; i< incList.length ; i++ ){
      row = grid.rows.add();
      row.cells[0].value = "${incList[i]["income"]}";
      row.cells[1].value = "${incList[i]["category"]}";
      row.cells[2].value = "${incList[i]["date"]}";
    }

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(10, 10, 0, 0));

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Income_Output.pdf');
  }




}
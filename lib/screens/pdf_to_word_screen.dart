import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PDFToWordScreen extends StatefulWidget {
  const PDFToWordScreen({super.key});

  @override
  State<PDFToWordScreen> createState() => _PDFToWordScreenState();
}

class _PDFToWordScreenState extends State<PDFToWordScreen> {
  String? _fileName;

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF to Word")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: pickPDF, child: const Text("Pick PDF")),
            const SizedBox(height: 20),
            Text(_fileName ?? "No file selected"),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ✅ gallery multi-select
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class PdfConversionPage extends StatefulWidget {
  const PdfConversionPage({super.key});

  @override
  State<PdfConversionPage> createState() => _PdfConversionPageState();
}

class _PdfConversionPageState extends State<PdfConversionPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selected = [];

  Future<void> _pickImages() async {
    try {
      final images = await _picker.pickMultiImage(
        imageQuality: 100, // keep quality; adjust if you need smaller PDF
      );
      if (images.isNotEmpty) {
        setState(() => _selected = images);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('⚠️ Could not open gallery: $e')));
    }
  }

  Future<void> _convertToPDF() async {
    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Please select images first')),
      );
      return;
    }

    try {
      final pdf = pw.Document();

      for (final x in _selected) {
        final bytes = await x.readAsBytes();
        final img = pw.MemoryImage(bytes);
        pdf.addPage(
          pw.Page(
            build: (context) =>
                pw.Center(child: pw.Image(img, fit: pw.BoxFit.contain)),
          ),
        );
      }

      // Name PDF based on first image name (without extension)
      final firstName = _selected.first.name.split('.').first;
      final dir =
          await getApplicationDocumentsDirectory(); // works without storage perms
      final file = File('${dir.path}/$firstName.pdf');
      await file.writeAsBytes(await pdf.save());

      // Success dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('🎉 PDF Successfully Created'),
          content: Text('Saved at:\n${file.path}'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                await OpenFilex.open(file.path);
              },
              child: const Text('Open PDF'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('⚠️ Error while creating PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Conversion'),
        backgroundColor: const Color.fromARGB(255, 55, 77, 75),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _pickImages,
            icon: const Icon(Icons.photo_library),
            tooltip: 'Pick Images',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _selected.isEmpty
                ? const Center(child: Text('No images selected'))
                : ListView.builder(
                    itemCount: _selected.length,
                    itemBuilder: (context, i) {
                      final x = _selected[i];
                      return ListTile(
                        leading: Image.file(
                          File(x.path),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(x.name),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Select Images'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _convertToPDF,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Convert'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

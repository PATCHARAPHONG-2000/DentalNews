import 'package:dental_news/Firebase/Jason_Knowledge.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ViwePDF_Knowledge extends StatefulWidget {
  final PDFDocument pdfDocument;
  final New_Knowledge new_knowledge;
  ViwePDF_Knowledge(
      {super.key, required this.new_knowledge, required this.pdfDocument});

  @override
  State<ViwePDF_Knowledge> createState() => _ViwePDF_KnowledgeState();
}

class _ViwePDF_KnowledgeState extends State<ViwePDF_Knowledge> {
  late New_Knowledge knowledge;

  get pdfDocument => PDFDocument();
  // PDFDocument pdfDocument;

  @override
  void initState() {
    super.initState();
    knowledge = widget.new_knowledge;
    viwepdf();
  }

  Future<Null> viwepdf() async {
    try {
      var result = await PDFDocument.fromURL(knowledge.pdf);
      setState(() {
        var pdfDocument = result;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(knowledge.name),
      ),
      body: pdfDocument == null
          ? Center(child: CircularProgressIndicator())
          : PDFViewer(document: pdfDocument),
    );
  }
}

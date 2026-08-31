// lib/screens/grassroots_elections.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../theme/theme_ext.dart';

class GrassrootsElectionsScreen extends StatefulWidget {
  const GrassrootsElectionsScreen({super.key});

  @override
  State<GrassrootsElectionsScreen> createState() =>
      _GrassrootsElectionsScreenState();
}

class _GrassrootsElectionsScreenState extends State<GrassrootsElectionsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'GRASSROOTS ELECTIONS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            _buildHeaderBanner(),
            const SizedBox(height: 20),

            // Title Section
            const Text(
              'UDA Grassroots Elections',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Phase III Grassroots Elections - County Aspirants Lists',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Loading Indicator
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Color(0xFF1A5C2A)),
                ),
              ),

            // Documents List
            _buildDocumentCard(
              title: 'UDA PHASE III GRASSROOTS ELECTIONS - NAKURU ASPIRANTS',
              county: 'NAKURU',
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onDownload: () => _downloadPDF('Nakuru'),
              onView: () => _viewPDF('Nakuru'),
            ),
            const SizedBox(height: 16),

            _buildDocumentCard(
              title: 'UDA PHASE III GRASSROOTS ELECTIONS - KAKAMEGA ASPIRANTS',
              county: 'KAKAMEGA',
              icon: Icons.picture_as_pdf,
              color: Colors.blue,
              onDownload: () => _downloadPDF('Kakamega'),
              onView: () => _viewPDF('Kakamega'),
            ),
            const SizedBox(height: 16),

            _buildDocumentCard(
              title: 'UDA PHASE III GRASSROOTS ELECTIONS - MOMBASA ASPIRANTS',
              county: 'MOMBASA',
              icon: Icons.picture_as_pdf,
              color: Colors.green,
              onDownload: () => _downloadPDF('Mombasa'),
              onView: () => _viewPDF('Mombasa'),
            ),
            const SizedBox(height: 16),

            _buildDocumentCard(
              title: 'UDA PHASE III GRASSROOTS ELECTIONS - KISUMU ASPIRANTS',
              county: 'KISUMU',
              icon: Icons.picture_as_pdf,
              color: Colors.orange,
              onDownload: () => _downloadPDF('Kisumu'),
              onView: () => _viewPDF('Kisumu'),
            ),
            const SizedBox(height: 16),

            _buildDocumentCard(
              title: 'UDA PHASE III GRASSROOTS ELECTIONS - NAIROBI ASPIRANTS',
              county: 'NAIROBI',
              icon: Icons.picture_as_pdf,
              color: Colors.purple,
              onDownload: () => _downloadPDF('Nairobi'),
              onView: () => _viewPDF('Nairobi'),
            ),
            const SizedBox(height: 16),

            // Information Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFCC00)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF1A5C2A),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Phase III Grassroots Elections',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A5C2A),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Download the aspirants list for your county and verify your details.',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Election Timeline
            _buildElectionTimeline(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Header Banner
  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UDA Grassroots Elections',
            style: TextStyle(
              color: Color(0xFF1A5C2A),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Party members elect their leaders at the ward, constituency and '
            'county levels to build a democratic grassroots structure.',
            style: TextStyle(color: context.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC00),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.how_to_vote, color: Color(0xFF1A5C2A), size: 16),
                SizedBox(width: 8),
                Text(
                  'GRASSROOTS DEMOCRACY',
                  style: TextStyle(
                    color: Color(0xFF1A5C2A),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Document Card
  Widget _buildDocumentCard({
    required String title,
    required String county,
    required IconData icon,
    required Color color,
    required VoidCallback onDownload,
    required VoidCallback onView,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: context.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UDA PHASE III GRASSROOTS ELECTIONS',
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$county ASPIRANTS',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF1A5C2A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onView,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A5C2A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'View',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onDownload,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.download,
                          color: Color(0xFF1A5C2A),
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Download',
                          style: TextStyle(
                            color: Color(0xFF1A5C2A),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Election Timeline
  Widget _buildElectionTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Election Timeline',
            style: TextStyle(
              color: Color(0xFF1A5C2A),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildTimelineItem(
            date: '15 March 2025',
            title: 'Nomination Period',
            description: 'Aspirants submit their nomination papers',
            isFirst: true,
          ),
          _buildTimelineItem(
            date: '25 March 2025',
            title: 'Vetting Process',
            description: 'Screening and verification of candidates',
            isFirst: false,
          ),
          _buildTimelineItem(
            date: '5 April 2025',
            title: 'Campaign Period',
            description: 'Official campaign period begins',
            isFirst: false,
          ),
          _buildTimelineItem(
            date: '15 April 2025',
            title: 'Election Day',
            description: 'Voting takes place across all wards',
            isFirst: false,
          ),
          _buildTimelineItem(
            date: '20 April 2025',
            title: 'Results Announcement',
            description: 'Official results released',
            isFirst: false,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String title,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isFirst || isLast
                    ? const Color(0xFFFFCC00)
                    : context.hairline,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A5C2A), width: 2),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 50, color: context.hairline),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: context.textMuted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // PDF Generation and Download Methods
  Future<void> _downloadPDF(String county) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pdf = await _generatePDF(county);

      // Save PDF to device
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/UDA_Grassroots_Elections_$county.pdf');
      await file.writeAsBytes(pdf);

      setState(() {
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ PDF downloaded successfully: $county Aspirants'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // Open the PDF
      await Printing.sharePdf(
        bytes: pdf,
        filename: 'UDA_Grassroots_Elections_$county.pdf',
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error downloading PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _viewPDF(String county) async {
    try {
      final pdf = await _generatePDF(county);

      // Preview PDF
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error viewing PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<Uint8List> _generatePDF(String county) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                color: const PdfColor.fromInt(0xFF1A5C2A),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'UDA GRASSROOTS ELECTIONS 2025',
                      style: pw.TextStyle(
                        fontSize: 24,
                        color: const PdfColor.fromInt(0xFFFFCC00),
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'PHASE III - $county COUNTY ASPIRANTS',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Content
              pw.Padding(
                padding: const pw.EdgeInsets.all(16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'LIST OF ASPIRANTS',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor.fromInt(0xFF1A5C2A),
                      ),
                    ),
                    pw.SizedBox(height: 8),

                    // Sample aspirants data
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: PdfColor.fromInt(0xFF1A5C2A),
                          ),
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                '#',
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                'Full Name',
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                'Position',
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                'Ward',
                                style: pw.TextStyle(
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Sample data rows
                        ..._getAspirants(county).map((aspirant) {
                          return pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(aspirant['number']!),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(aspirant['name']!),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(aspirant['position']!),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(aspirant['ward']!),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),

                    pw.SizedBox(height: 20),

                    pw.Container(
                      padding: const pw.EdgeInsets.all(12),
                      decoration: const pw.BoxDecoration(
                        color: PdfColor.fromInt(0xFFFFCC00),
                        borderRadius: pw.BorderRadius.all(
                          pw.Radius.circular(8),
                        ),
                      ),
                      child: pw.Text(
                        'Total Aspirants: ${_getAspirants(county).length}',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: const PdfColor.fromInt(0xFF1A5C2A),
                        ),
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    pw.Text(
                      'For more information, visit: www.uda.co.ke',
                      style: pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  List<Map<String, String>> _getAspirants(String county) {
    // Sample data - in real app, this would come from an API
    final sampleData = {
      'Nakuru': [
        {
          'number': '1',
          'name': 'John K. Mwangi',
          'position': 'Ward Representative',
          'ward': 'Nakuru East',
        },
        {
          'number': '2',
          'name': 'Mary W. Njeri',
          'position': 'County Assembly Member',
          'ward': 'Nakuru West',
        },
        {
          'number': '3',
          'name': 'Peter O. Ochieng',
          'position': 'Member of County Assembly',
          'ward': 'Naivasha',
        },
        {
          'number': '4',
          'name': 'Grace A. Achieng',
          'position': 'Ward Representative',
          'ward': 'Gilgil',
        },
        {
          'number': '5',
          'name': 'James K. Kimani',
          'position': 'County Assembly Member',
          'ward': 'Njoro',
        },
      ],
      'Kakamega': [
        {
          'number': '1',
          'name': 'David S. Shikuku',
          'position': 'Ward Representative',
          'ward': 'Kakamega Central',
        },
        {
          'number': '2',
          'name': 'Sarah N. Nyongesa',
          'position': 'County Assembly Member',
          'ward': 'Kakamega East',
        },
        {
          'number': '3',
          'name': 'Michael O. Omolo',
          'position': 'Member of County Assembly',
          'ward': 'Kakamega West',
        },
        {
          'number': '4',
          'name': 'Jane A. Amukhuma',
          'position': 'Ward Representative',
          'ward': 'Butere',
        },
        {
          'number': '5',
          'name': 'Robert W. Wanjala',
          'position': 'County Assembly Member',
          'ward': 'Mumias',
        },
      ],
      'Mombasa': [
        {
          'number': '1',
          'name': 'Hassan A. Omar',
          'position': 'Ward Representative',
          'ward': 'Mombasa Central',
        },
        {
          'number': '2',
          'name': 'Fatma K. Salim',
          'position': 'County Assembly Member',
          'ward': 'Mombasa East',
        },
        {
          'number': '3',
          'name': 'Ali M. Juma',
          'position': 'Member of County Assembly',
          'ward': 'Mombasa West',
        },
        {
          'number': '4',
          'name': 'Zainab A. Mohamed',
          'position': 'Ward Representative',
          'ward': 'Kisauni',
        },
        {
          'number': '5',
          'name': 'Omar B. Bakari',
          'position': 'County Assembly Member',
          'ward': 'Likoni',
        },
      ],
      'Kisumu': [
        {
          'number': '1',
          'name': 'David O. Odhiambo',
          'position': 'Ward Representative',
          'ward': 'Kisumu Central',
        },
        {
          'number': '2',
          'name': 'Caroline A. Akinyi',
          'position': 'County Assembly Member',
          'ward': 'Kisumu East',
        },
        {
          'number': '3',
          'name': 'Joseph A. Omondi',
          'position': 'Member of County Assembly',
          'ward': 'Kisumu West',
        },
        {
          'number': '4',
          'name': 'Mercy N. Achieng',
          'position': 'Ward Representative',
          'ward': 'Winam',
        },
        {
          'number': '5',
          'name': 'Timothy O. Onyango',
          'position': 'County Assembly Member',
          'ward': 'Nyando',
        },
      ],
      'Nairobi': [
        {
          'number': '1',
          'name': 'James M. Kamau',
          'position': 'Ward Representative',
          'ward': 'Nairobi Central',
        },
        {
          'number': '2',
          'name': 'Susan W. Muthoni',
          'position': 'County Assembly Member',
          'ward': 'Nairobi East',
        },
        {
          'number': '3',
          'name': 'Patrick O. Ochieng',
          'position': 'Member of County Assembly',
          'ward': 'Nairobi West',
        },
        {
          'number': '4',
          'name': 'Mary K. Wanjiru',
          'position': 'Ward Representative',
          'ward': 'Dagoretti',
        },
        {
          'number': '5',
          'name': 'George N. Kimani',
          'position': 'County Assembly Member',
          'ward': 'Embakasi',
        },
      ],
    };

    return sampleData[county] ??
        [
          {
            'number': '1',
            'name': 'Sample Aspirant',
            'position': 'Ward Representative',
            'ward': 'Sample Ward',
          },
        ];
  }
}

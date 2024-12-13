import 'package:dentalnews/Model/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Firebase/Dental_Clinic.dart';
import 'Clinic_Detel.dart';

// ignore: camel_case_types
class Home_Clinic extends StatefulWidget {
  const Home_Clinic({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Home_ClinicState createState() => _Home_ClinicState();
}

class _Home_ClinicState extends State<Home_Clinic> {
  bool _isSearching = false;
  List<ClinicFirebase> _allResults = [];
  List<ClinicFirebase> _resultList = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getClientStream();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    List<ClinicFirebase> showResults = [];
    if (_searchController.text.isNotEmpty) {
      for (var clientSnapshot in _allResults) {
        var name = clientSnapshot.name.toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  Future<void> getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Dental_Clinic')
        .orderBy('name')
        .get();

    if (mounted) {
      setState(() {
        _allResults =
            data.docs.map((doc) => ClinicFirebase.fromFirestore(doc)).toList();
        searchResultList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  String _formatWorkingDays(List<Map<String, dynamic>> workingDays) {
    // รายชื่อวันในภาษาไทย
    const daysInThai = [
      "วันจันทร์",
      "วันอังคาร",
      "วันพุธ",
      "วันพฤหัสบดี",
      "วันศุกร์",
      "วันเสาร์",
      "วันอาทิตย์"
    ];

    // ดึงชื่อวันจาก workingDays
    final openedDays = workingDays.map((dayMap) => dayMap['day']).toList();

    // ตรวจสอบว่าครอบคลุมทุกวันหรือไม่
    if (openedDays.length == 7 ||
        ListEquality().equals(openedDays, daysInThai)) {
      return "เปิดทุกวัน";
    }

    // หากวันเริ่มต้นที่จันทร์และจบที่อาทิตย์
    if (openedDays.contains("วันจันทร์") && openedDays.contains("วันอาทิตย์")) {
      return "วันจันทร์ ถึง วันอาทิตย์";
    }

    // แสดงรายการวันทำการแบบปกติ
    return openedDays.join(", ");
  }

  Widget createWidget(ClinicFirebase clinic) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Clinic_Detel(
                    clinicData: clinic,
                  );
                },
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Colors.grey[200]!,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinic.name,
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).splashColor),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  if (clinic.workingDays.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'วันเปิดทำการ: ',
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).splashColor),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: Text(
                            _formatWorkingDays(clinic.workingDays),
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).splashColor),
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPang(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: _isSearching
            ? CupertinoSearchTextField(
                controller: _searchController,
                itemColor: Theme.of(context).dividerColor,
                style: TextStyle(color: Theme.of(context).dividerColor),
              )
            : Text(
                tr('app.Clinic'),
                style: GoogleFonts.k2d(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
        actions: [
          IconButton(
            color: Theme.of(context).dividerColor,
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_isSearching) {
                _stopSearch();
              } else {
                _startSearch();
              }
            },
          ),
        ],
      ),
      body: _resultList.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : ListView.builder(
              itemCount: _resultList.length,
              itemBuilder: (BuildContext context, int index) {
                ClinicFirebase clinicData = _resultList[index];

                return createWidget(clinicData);
              },
            ),
    );
  }
}

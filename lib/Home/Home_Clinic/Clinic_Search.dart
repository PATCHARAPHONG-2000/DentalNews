import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ClinicSearch extends StatefulWidget {
  const ClinicSearch({super.key});

  @override
  State<ClinicSearch> createState() => _ClinicSearchState();
}

class _ClinicSearchState extends State<ClinicSearch> {
  List _allResults = [];
  List _resultList = [];
  bool isLoading = true;
  Timer? _debounce;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    getClientStream();
    super.initState();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchResultList();
    });
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text.isNotEmpty) {
      for (var clientSnapshot in _allResults) {
        var name = clientSnapshot['name'].toString().toLowerCase();
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
    try {
      var data = await FirebaseFirestore.instance
          .collection('Dental_Clinic')
          .orderBy('name')
          .get();

      setState(() {
        _allResults = data.docs;
        searchResultList();
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _searchController,
          itemColor: Theme.of(context).dividerColor,
          style: TextStyle(color: Theme.of(context).dividerColor),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : _resultList.isEmpty
              ? const Center(
                  child: Text(
                    'No results found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _resultList.length,
                  itemBuilder: (context, int index) {
                    var clinicSnapshot = _resultList[index];
                    return GestureDetector(
                      onTap: () {
                        // Add your navigation or action here
                      },
                      child: ListTile(
                        title: Text(
                          clinicSnapshot['name'],
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize:
                                screenWidth * 0.05, // Responsive font size
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

// ignore_for_file: file_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/search.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1.0,
          color: Colors.white,
        ),
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Search Palia'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchSDP(
                // dashboardindexNumber: 0,
                searchDasboardIndexNumber: 0,
                onSubmitPress:
                    (result, selectedSearchType, sdpSearchController) {
                  // dashboardindexNumber = 0;
                  log(selectedSearchType);
                  log(sdpSearchController);
                },
              ),
            ),
          ),
        );
      },
      child: const Text('Search'),
    );
  }
}

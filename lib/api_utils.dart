import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screens/details_screen.dart';

/// Fetch details for a specific show from the TVMaze API.
/// Navigates to the DetailsScreen to display the information.
Future<void> fetchDetails(BuildContext context, int showId) async {
  try {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/shows/$showId?embed=cast'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> details = json.decode(response.body);

      // Add the cast information
      details['cast'] = details['_embedded']['cast'];

      // Navigate to the DetailsScreen with the show details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(details),
        ),
      );
    } else {
      throw Exception('Failed to load details: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching details: $error');
  }
}

/// Remove HTML tags from a given HTML string.
String removeHtmlTags(String htmlString) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}

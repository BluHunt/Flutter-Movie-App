import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_utils.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            // Trigger search when the text in the search bar changes
            searchMovies(value);
          },
          onEditingComplete: () {
            // Trigger search when the user finishes editing the search bar
            searchMovies(_searchController.text);
          },
          decoration: InputDecoration(
            hintText: 'Search for movies',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Trigger search when the search icon is pressed
              searchMovies(_searchController.text);
            },
          ),
        ],
      ),
      body: searchResults.isEmpty
          ? Center(child: Text('No results'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var show = searchResults[index]['show'];
          return GestureDetector(
            onTap: () {
              // Handle card tap here
              fetchDetails(context, show['id']);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0)),
                        image: DecorationImage(
                          image: show['image'] != null
                              ? NetworkImage(show['image']['original'])
                              : AssetImage('assets/logo.jpg')
                          as ImageProvider<Object>,
                          fit: BoxFit.cover, // Adjust the fit property here
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(6.0),
                      title: Text(
                        show['name'] ?? 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: Text(
                            removeHtmlTags(show['summary'] ?? 'N/A'),
                            maxLines:
                            1, // Set the maximum number of lines
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if overflow
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          )),
                      onTap: () {
                        // Handle card tap here
                        fetchDetails(context, show['id']);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Fetch data from the API based on the search term
  Future<void> searchMovies(String searchTerm) async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm'));
      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}

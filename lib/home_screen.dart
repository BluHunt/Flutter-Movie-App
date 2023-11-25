import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_utils.dart';
import 'screens/search_screen.dart';
import 'screens/details_screen.dart';
import 'package:html_unescape/html_unescape.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> shows = [];
  final HtmlUnescape _htmlUnescape = HtmlUnescape();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch data from the API
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
      if (response.statusCode == 200) {
        setState(() {
          shows = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to the SearchScreen on search icon tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: shows.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: shows.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle card tap here
              fetchDetails(context, shows[index]['show']['id']);
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                        image: DecorationImage(
                          image: shows[index]['show']['image'] != null
                              ? NetworkImage(shows[index]['show']['image']['original'])
                              : AssetImage('assets/logo.jpg') as ImageProvider<Object>,
                          fit: BoxFit.cover, // Adjust the fit property here
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(6.0),
                      title: Text(
                        shows[index]['show']['name'] ?? 'N/A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Container(
                          margin: EdgeInsets.only(top: 8.0),
                          child: Text(
                            removeHtmlTags(shows[index]['show']['summary'] ?? 'N/A'),
                            maxLines: 1, // Set the maximum number of lines
                            overflow: TextOverflow.ellipsis, // Add ellipsis if overflow
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          )),
                      onTap: () {
                        // Handle card tap here
                        fetchDetails(context, shows[index]['show']['id']);
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
}

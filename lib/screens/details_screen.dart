import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../api_utils.dart';

/// DetailsScreen widget displays detailed information about a TV show.
class DetailsScreen extends StatelessWidget {
  final dynamic show;

  DetailsScreen(this.show);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(show['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the show's image using CachedNetworkImage
            CachedNetworkImage(
              imageUrl: show['image']['original'],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // Display the show's summary
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // Remove HTML tags from the summary
                removeHtmlTags(show['summary']),
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            // Display the cast information
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cast:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            // List the cast members using a ListView
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: show['cast'] != null ? show['cast'].length : 0,
              itemBuilder: (context, index) {
                return ListTile(
                  // Display the actor's name
                  title: Text(show['cast'][index]['person']['name']),
                  // Display the character's name
                  subtitle: Text(show['cast'][index]['character']['name']),
                  // Display the actor's image using CircleAvatar
                  leading: CircleAvatar(
                    backgroundImage: show['cast'][index]['person']['image'] != null
                        ? NetworkImage(
                        show['cast'][index]['person']['image']['medium'])
                        : AssetImage('assets/default_avatar.png')
                    as ImageProvider<Object>?,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

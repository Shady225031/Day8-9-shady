// ignore_for_file: prefer_const_constructors

import 'package:day8/model/tvshow.dart';
import 'package:day8/web_services/api_service.dart';
import 'package:flutter/material.dart';

class TvShowDetailsScreen extends StatelessWidget {
  TvShowDetailsScreen({super.key, required this.tvShowId});
  final int tvShowId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('TV Show Details'),
      ),
      body: FutureBuilder<TvShow>(
        future: ApiService().getTvShowById(tvShowId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
                color: Colors.purpleAccent,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                'No Data Available',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          final tvShow = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: tvShow.posterPath.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                              ),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: tvShow.posterPath.isEmpty ? Colors.grey[300] : null,
                    ),
                    child: tvShow.posterPath.isEmpty
                        ? Center(
                            child: Text(
                              'No Image Available',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  tvShow.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Release Date: ${tvShow.firstAirDate}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  tvShow.overview.isNotEmpty
                      ? tvShow.overview
                      : 'No description available',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Rating: ${tvShow.voteAverage.toStringAsFixed(1)} ⭐ (${tvShow.voteCount} votes)',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange[800],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

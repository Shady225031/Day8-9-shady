// ignore_for_file: prefer_const_constructors

import 'package:day8/screens/product_details.dart';
import 'package:day8/web_services/api_service.dart';
import 'package:day8/model/movie.dart';
import 'package:day8/model/product.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> movies = [];
  bool isLoading = false;
  bool isFetchingMore = false;
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchMovies();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isFetchingMore) {
        fetchMoreMovies();
      }
    });
  }

  Future<void> fetchMovies() async {
    setState(() => isLoading = true);
    try {
      movies = await ApiService().getMovies(currentPage);
    } catch (e) {
      showError(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchMoreMovies() async {
    setState(() => isFetchingMore = true);
    try {
      currentPage++;
      final moreMovies = await ApiService().getMovies(currentPage);
      if (moreMovies.isNotEmpty) {
        setState(() => movies.addAll(moreMovies));
      }
    } catch (e) {
      showError(e.toString());
    } finally {
      setState(() => isFetchingMore = false);
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Movies', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: isLoading
          ? _buildShimmerEffect()
          : movies.isEmpty
              ? Center(child: Text("No Movies Available"))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: movies.length + (isFetchingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == movies.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final movie = movies[index];
                    return _buildMovieCard(movie);
                  },
                ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 150,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(movie.overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 5),
                    Text('${movie.voteAverage} / 10',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}